
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Interactive Attribution Graph Demo</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://d3js.org/d3.v7.min.js"></script>

  <style>
    :root {
      --node-fill: #f2e7fa;
      --node-stroke: #a472d1;
      --edge-stroke: #d8b4fe;
      --dashboard-bg: #1f102f;
      --dashboard-text: #e0d0f5;
      --dashboard-border: #4b2c73;
    }

    body {
      background: linear-gradient(180deg, #1a0033 0%, #0a0018 100%);
      padding: 1.5rem;
      font-family: 'Inter', sans-serif;
      color: var(--dashboard-text);
    }

    .node rect {
      fill: var(--node-fill);
      stroke: var(--node-stroke);
      stroke-width: 1.2px;
      rx: 8px;
    }

    .node.input rect {
      /* width: 16px;
      height: 30px; */
      rx: 4px;
      fill: #6b21a8;
      stroke: #6b21a8;
    }
    .node.input text {
      font-size: 0.65rem;
      fill: #e0d0f5;
    }

    .edge-path {
      fill: none;
      stroke: var(--edge-stroke);
      stroke-width: 2px;
      opacity: 0.8;
    }

    .stack rect:nth-child(2) { transform: translate(2px,2px);}
    .stack rect:nth-child(3) { transform: translate(4px,4px);}

    #dashboard {
      position: absolute;
      width: 24rem;
      max-width: 90vw;
      max-height: 80vh;
      overflow-y: auto;
      background: var(--dashboard-bg);
      color: var(--dashboard-text);
      border: 1px solid var(--dashboard-border);
      box-shadow: 0 8px 20px rgba(80,0,150,0.25);
      border-radius: 1rem;
      display: none;
      z-index: 9999;
      overflow-x: hidden; 
    }

    #feat-tabs button {
      background-color: #371651;
      color: #e0d0f5;
      border: 1px solid #5c2f7e;
    }
    #feat-tabs button.bg-gray-200 {
      background-color: #6b21a8;
      color: #f3e8ff;
    }

    svg#graph {
      border: 1px solid var(--dashboard-border);
      border-radius: 1rem;
      background: rgba(255, 255, 255, 0.02);
    }
  </style>
</head>

<body class="antialiased p-6 select-none">
<!-- <div style="width: 100%; overflow-x: auto; overflow-y: hidden;">
  <svg id="graph" class="w-full h-[700px]"></svg>
</div> -->
<div style="width: 100%; overflow-x: auto; overflow-y: hidden;">
  <svg id="graph" height="700"></svg>
</div>


<aside id="dashboard"></aside>

<script>
const layerY = {
  4: 600,
  8: 500,
  12: 400,
  16: 300,
  20: 200,
  24: 100,
  28: 0
};

const sequence = "MSTEPVSASDKYQKISQLEHILKRPDTYIGSVETQEQLQWIYDEETDCMIEKNVTIVPGLFKIFDEILVNAADNKVRDPSMKRIDVNIHAEEHTIEVKNDGKGIPIEIHNKENIYIPEMIFGHLLTSSNYDDDEKKVTGGRNGYGAKLCNIFSTEFILETADLNVGQKYVQKWENNMSICHPPKITSYKKGPSYTKVTFKPDLTRFGMKELDNDILGVMRRRVYDINGSVRDINVYLNGKSLKIRNFKNYVELYLKSLEKKRQLDNGEDGAAKSDIPTILYERINNRWEVAFAVSDISFQQIS";

const mainNodes = [
  {id:"N_last",label:"_N",type:"super",members:["4.3170"],x:150,layer:4},
  {id:"D_last",label:"D_",type:"super",members:["4.527"],x:150,layer:4},
  {id:"G_last",label:"G_",type:"super",members:["4.3069"],x:150,layer:4},
  {id:"GXG_mid",label:"GXG",type:"super",members:["8.3903","8.1055","8.2066"],x:50,layer:8}, 
  {id:"C_spec",label:"C",type:"super",members:["4.3544"],x:50,layer:4}, 
  {id:"YX_",label:"YX_",type:"super",members:["4.2112"],x:50,layer:4}, 
  {id:"I_spec",label:"I",type:"super",members:["4.1297"],x:50,layer:4}, 
  {id:"XXN",label:"_XXN",type:"super",members:["4.1468"],x:50,layer:4}, 
  {id:"IL?",label:"IL?",type:"super",members:["4.100"],x:50,layer:4}, 
  {id:"IX_",label:"IX_",type:"super",members:["4.3229"],x:50,layer:4},
   {id:"N_spec",label:"N",type:"super",members:["4.2929"],x:50,layer:4}, 
   {id:"D_spec",label:"D",type:"super",members:["4.1196"],x:50,layer:4}, 
   {id:"E_spec",label:"E",type:"super",members:["4.1509"],x:50,layer:4}, 
   {id:"XQX",label:"_XQ",type:"super",members:["4.2511"],x:50,layer:4}, 
   {id:"NXXXNA",label:"NXXXNA\nHATPase",type:"super",members:["8.3159", "8.1916"],x:50,layer:8}, 
   {id:"IXVXD",label:"IXVXD\nHATPase",type:"super",members:["8.2527"],x:50,layer:8}, 
   {id:"sheet_alpha",label:"Sheets around alpha",type:"super",members:["8.2662"],x:50,layer:8}, 
   {id:"alt_beta",label:"alternate Beta residues",type:"super",members:["8.2621"],x:50,layer:8}, 
   {id:"repeat_dn",label:"Repeating D,N",type:"super",members:["8.3921"],x:50,layer:8}, 
   {id:"hatpase_segment",label:"Beta in HATPase",type:"super",members:["12.3943", "12.1796", "12.1145"],x:50,layer:12}, 
  // {id:"hatpase_segment",label:"Beta in HATPase",type:"super",members:["12.3943", "12.1796"],x:50,layer:12}, 
{id:"general_beta",label:"Beta Strands",type:"super",members:["12.2474"],x:50,layer:12}, 
{id:"GHKL_12",label:"GHKL Domain",type:"super",members:["12.1204"],x:50,layer:12}, 
{id:"yeast_12",label:"Yeast proteins",type:"super",members:["12.3849"],x:50,layer:12}, 
{id:"kinesin_12",label:"Kinesin Domain",type:"super",members:["12.2472"],x:50,layer:12}, 
{id:"xpg_12",label:"XPG-I Domain",type:"super",members:["12.1082"],x:50,layer:12}, 
{id:"beta_16",label:"Beta in yeast",type:"super",members:["16.3666"],x:50,layer:16}, 
{id:"hatpase_segment_16",label:"Beta in HATPase",type:"super",members:["16.1353", "16.1597", "16.631"],x:50,layer:16}, 
{id:"GHKL_16",label:"GHKL Domain",type:"super",members:["16.1166", "16.1280", "16.737"],x:50,layer:16}, 
{id:"beta_20",label:"Beta",type:"super",members:["20.3462", "20.789", "20.2366 "],x:50,layer:20}, 
{id:"LXVXF",label:"LX[v,F]XF",type:"super",members:["20.1799"],x:50,layer:20}, 
{id:"hatpase_segment_20",label:"Beta in HATPase",type:"super",members:["20.1108", "20.432"],x:50,layer:20}, 
{id:"GHKL_20",label:"GHKL Domain",type:"super",members:["20.2311", "20.432"],x:50,layer:20}, 
];

// right after you declare mainNodes...
const featureLayer = {};
mainNodes.forEach(n=>{
  n.members.forEach(fid=>{
    featureLayer[fid] = n.layer;
  });
});



// top of your <script>:
const xStep = 12;   // <-- up from 12 to 16 (try 18 or 20 too)

// ...later, when you build your input nodes:
const inputNodes = Array.from(sequence).map((aa, i) => ({
  id:    `residue_${i+1}`,
  label: `${aa}\n${i+1}`,
  type:  "input",
  x:     i * xStep,     // ← use xStep here
  y:     700
}));
const inputWidth = inputNodes.length * xStep + 400;

// Final graph data
const graphData = {
  nodes: [
  ...inputNodes, 
  ...mainNodes.map(node => ({
    ...node,
    y: layerY[node.layer] || node.y  // fallback if no layer
  }))
    ],
  edges: [
    {source:"residue_133",target:"GXG_mid"},
    {source:"residue_134",target:"GXG_mid"},
    {source:"residue_135",target:"GXG_mid"},
    {source:"residue_28",target:"C_spec"},
    {source:"residue_30",target:"YX_"},
    {source:"residue_67",target:"I_spec"},
    {source:"residue_265",target:"N_last"},
    {source:"residue_67",target:"XXN"},
    {source:"residue_67",target:"IL?"},
    {source:"residue_68",target:"IL?"},
    {source:"residue_97",target:"IX_"},
    {source:"residue_266",target:"XQX"},
    {source:"residue_268",target:"E_spec"},
    {source:"residue_266",target:"N_spec"},
    {source:"residue_265",target:"D_spec"},
    {source:"residue_266",target:"D_last"},
    {source:"residue_268",target:"G_last"},

    {source:"residue_67",target:"NXXXNA"},

    {source:"residue_97",target:"IXVXD"},

    {source:"residue_97",target:"sheet_alpha"},

    {source:"residue_197",target:"sheet_alpha"},

    {source:"residue_197",target:"alt_beta"},

    {source:"residue_65",target:"repeat_dn"},
    {source:"residue_212",target:"repeat_dn"},
    {source:"residue_213",target:"repeat_dn"},
    {source:"residue_266",target:"repeat_dn"},

    {source:"residue_98",target:"hatpase_segment"},
    {source:"residue_195",target:"hatpase_segment"},
    {source:"residue_197",target:"hatpase_segment"},

    {source:"residue_197",target:"general_beta"},

    {source:"residue_197",target:"GHKL_12"},

    {source:"residue_197",target:"yeast_12"},

    {source:"residue_97",target:"xpg_12"},

    {source:"residue_197",target:"kinesin_12"},

    {source:"residue_197",target:"beta_16"},

    {source:"residue_195",target:"hatpase_segment_16"},
    {source:"residue_196",target:"hatpase_segment_16"},
    {source:"residue_197",target:"hatpase_segment_16"},
    {source:"residue_199",target:"hatpase_segment_16"},
    {source:"residue_201",target:"hatpase_segment_16"},

    {source:"residue_195",target:"GHKL_16"},
    {source:"residue_197",target:"GHKL_16"},
    {source:"residue_199",target:"GHKL_16"},
    {source:"residue_201",target:"GHKL_16"},

    {source:"residue_197",target:"beta_20"},

    {source:"residue_197",target:"LXVXF"},
    {source:"residue_199",target:"LXVXF"},

    {source:"residue_195",target:"hatpase_segment_20"},
    {source:"residue_197",target:"hatpase_segment_20"},
    {source:"residue_199",target:"hatpase_segment_20"},

    {source:"residue_195",target:"GHKL_20"},
  ],
  
  features: {
  "8.3903": {
    description: "Fires on GXG pattern, this is present in 1PVG but is masked. It has causal effect over tokens right before GYG, so hypothesis: approximate masked token prediction. Fires over D133,E134,K135. Top proteins also share HATPase domain and atp binding function.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+1+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+1+Plot+2"
  },
  "8.1055": {
    description: "Fires on GXG pattern, this is present in 1PVG but is masked. It has causal effect over tokens right before GYG, so hypothesis: approximate masked token prediction. Fires on V97 and 127:136. Top proteins also share HATPase domain and atp binding function.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+2+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+2+Plot+2"
  },
  "8.2066": {
    description: "Fires on GXG pattern, this is present in 1PVG but is masked. It has causal effect over tokens right before GYG, so hypothesis: approximate masked token prediction. Fires over D133,E134,K135. Top proteins also share HATPase domain and atp binding function.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+3+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+3+Plot+2"
  },
  "4.3170": {
    description: "Fires right before N, inhibitory causal effect at 265D",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.527": {
    description: "Fires right after D, inhibitory causal effect at 266N",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.3069": {
    description: "Fires right after G, casual effect at 268G which is masked in clean.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.2511": {
    description: "Fires on _XQ, but also QX_ but weaker. Latter is present.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.3229": {
    description: "Fires on IX_, causal effect on V97, which has IE before it.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.1468": {
    description: "Fires on _XXN, effect on I67 before LVN.",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
  "4.100": {
    description: "Fires on around IL? unsure but new residues increase activation on I67,I86",
    activations: "",
    fig1: "circuits_1pvg_jump/l4_100_1.png",
    fig2: "circuits_1pvg_jump/l4_100_cons.png",
    fig3: "circuits_1pvg_jump/l4_100_IL.png"
  },
  "4.2112": {
    description: "Fires on YX_, fires on G30, which has YIG. Y was masked in corrupted. ",
    activations: "",
    // fig1: "https://via.placeholder.com/400x200?text=Feature+4+Plot+1",
    // fig2: "https://via.placeholder.com/400x200?text=Feature+4+Plot+2"
  },
}


};

/**************** 2. Render *****************/
const svg = d3.select('#graph');
const linkG = svg.append('g');
const nodeG = svg.append('g');
const dash = d3.select('#dashboard');
let hideId = null;
function nodeById(id){return graphData.nodes.find(n=>n.id===id);}
svg.attr('width', inputWidth);

/* ---------------- LAYER GUIDES ---------------- */
const layerGuideG = svg.append("g")
  .attr("pointer-events", "none");              // ignore mouse

Object.entries(layerY).forEach(([layer, y]) => {
  // dashed guide-line across full sequence width
  layerGuideG.append("line")
    .attr("x1", 0)
    .attr("y1", y + 20)                         // a little below node tops
    .attr("x2", inputWidth)                    // full scroll width
    .attr("y2", y + 20)
    .attr("stroke", "#9e7ac4")
    .attr("stroke-dasharray", "4 4")
    .attr("opacity", 0.35);

  // fixed label (absolutely-positioned so it never scrolls away)
  d3.select("body").append("div")
    .style("position", "fixed")
    .style("left", "8px")
    .style("top", `${y+30}px`)
    .style("color", "#e0d0f5")
    .style("font-size", "0.75rem")
    .style("pointer-events", "none")
    .text(`Layer ${layer}`);
});


/* ------------- RESIDUE SECTION BANDS ---------- */
const bandData = [
  {start: 27,  end: 28,  label: "clean"},
  {start: 92,  end: 102, label: "SSE-1"},
  {start: 192, end: 202, label: "SSE-2"},
  {start: 267, end: 268, label: "clean"},
  {start: 29,  end: 91,  label: "unmasked", color: "#45306d"},
  {start: 203, end: 266, label: "unmasked", color: "#45306d"}
];

const bandG = svg.insert("g","g");             // put **behind** nodes

bandData.forEach(b => {
  const bandX   = (b.start-1) * xStep;            // same 12-px grid
  const bandW   = (b.end - b.start + 1) * xStep;

  // semi-transparent rectangle
  bandG.append("rect")
    .attr("x", bandX)
    .attr("y", 750)                            // just beneath input boxes
    .attr("width", bandW)
    .attr("height", 40)
    .attr("fill", b.color || "#6a5499")
    .attr("opacity", 0.45)
    .attr("rx", 4);

  // label centred on the band
  bandG.append("text")
    .attr("x", bandX + bandW / 2)
    .attr("y", 772)                            // mid-height of rect
    .attr("text-anchor", "middle")
    .attr("dominant-baseline", "middle")
    .attr("font-size", "0.65rem")
    .attr("fill", "#e0d0f5")
    .text(b.label);
});

// edges
// linkG.selectAll('path').data(graphData.edges)
//   .enter().append('path')
//   .attr('d',d=>M${nodeById(d.source).x},${nodeById(d.source).y} L${nodeById(d.target).x},${nodeById(d.target).y})
//   .attr('class','edge-path');
// Mapping from nodeId -> array of residue IDs
const residueConnections = {};
const activeResidues = new Set();

graphData.edges.forEach(edge => {
  if (edge.source.startsWith("residue_")) {
    activeResidues.add(edge.source);
  }
});

graphData.edges.forEach(edge => {
  if (edge.source.startsWith("residue_")) {
    if (!residueConnections[edge.target]) {
      residueConnections[edge.target] = [];
    }
    residueConnections[edge.target].push(edge.source);
  }
});



// nodes
// const placedX = [];
// graphData.nodes.forEach(node => {
//   if (node.type !== "input" && residueConnections[node.id]) {
//     const sources = residueConnections[node.id];
//     const meanX = sources.reduce((acc, rid) => acc + nodeById(rid).x, 0) / sources.length;
//     node.x = meanX;

//     // --- collision handling ---
//     while (placedX.some(px => Math.abs(px - node.x) < 60)) {
//       node.x += 80;  // bump right
//     }
//     placedX.push(node.x);
//   }
// });
// (3) collision handling, grouped by layer:
const bumpThreshold = 60;  // “minimum” gap you want between main nodes
const bumpAmount    = 120;
const placedXByLayer = {};  // { layerValue: [x1,x2,...] }

graphData.nodes.forEach(node => {
  if (node.type !== "input" && residueConnections[node.id]) {
    const sources = residueConnections[node.id];
    const meanX   = sources.reduce((acc, rid) => acc + nodeById(rid).x, 0) / sources.length;
    let   x       = meanX;
    const layerKey = node.members && node.members.length > 0
               ? node.members[0]
               : null;
    const layer    = featureLayer[layerKey] || node.layer;
    // const layer   = featureLayer[node.members?.[0]] || node.layer;  // or however you store node.layer

    // init array for this layer
    if (!placedXByLayer[layer]) placedXByLayer[layer] = [];

    // bump until no collision *in the same layer*
    while (placedXByLayer[layer].some(px => Math.abs(px - x) < bumpThreshold)) {
      x += bumpAmount;
    }


    node.x = x;
    placedXByLayer[layer].push(x);
  }
});

// (4) Now draw edges
linkG.selectAll('path').data(graphData.edges)
  .enter().append('path')
  .attr('d', d => `M${nodeById(d.source).x + 8},${nodeById(d.source).y} L${nodeById(d.target).x + 55},${nodeById(d.target).y + 40}`)
  .attr('class', 'edge-path');

// (5) Now draw nodes
const nodes = nodeG.selectAll('g').data(graphData.nodes).enter().append('g')
  .attr('class', d => `node ${d.type}`)
  .attr('transform', d => `translate(${d.x},${d.y})`)



afterDraw();
function afterDraw(){
  nodes.each(function(d){
  const g = d3.select(this);
  let rect;
  
  if(d.type==='super'){
    g.classed('stack',true);
    [2,1,0].forEach(()=>g.append('rect').attr('width',110).attr('height',40));
  } else if(d.type==='input'){
    rect = g.append('rect')
      .attr('width', 12)
      .attr('height', 30)
      .attr('rx', 4)
      .attr('fill', '#6b21a8')
      .attr('stroke', '#6b21a8');
  } else {
    rect = g.append('rect')
      .attr('width',110)
      .attr('height',40);
  }
  
  d.label.split(/\n/).forEach((line,i,arr)=>{
    const t = g.append('text')
      .attr('x',d.type==='input'?8:55)
      .attr('y',22+(i-(arr.length-1)/2)*14)
      .attr('text-anchor','middle')
      .attr('dominant-baseline','middle')
      .attr('class','text-sm font-medium text-gray-800')
      .text(line);
    
    if (d.type === 'input' && !activeResidues.has(d.id)) {
      t.attr('font-size', '0.3rem')
       .attr('opacity', 0.1);
      
      rect.attr('width', 8)
          .attr('height', 30)
          .attr('opacity', 0.1);
    }
  });
});

}

/**************** 3. Interactivity *****************/
nodes.on('pointerenter',function(event,d){
  clearTimeout(hideId);
  renderPanel(d);
  positionPanelBeside(event.currentTarget);
});
nodes.on('pointerleave',()=>scheduleHide());
dash.on('pointerenter',()=>clearTimeout(hideId));
dash.on('pointerleave',()=>scheduleHide());

function scheduleHide(delay=400){
  clearTimeout(hideId);
  hideId=setTimeout(()=>dash.style('display','none'),delay);
}

function positionPanelBeside(svgNode){
  const rect=svgNode.getBoundingClientRect();
  const panel=dash.node();
  const panelWidth=panel.offsetWidth||320;
  let left=rect.right+16;
  let top=rect.top;
  if(left+panelWidth>window.innerWidth) left=rect.left-panelWidth-16;
  if(top+panel.offsetHeight>window.innerHeight) top=window.innerHeight-panel.offsetHeight-16;
  dash.style('left',left+"px").style('top',top+"px");
}

function renderPanel(d){
  if(d.type==='super'){
    dash.html(`<div class="p-4">
      <h2 class="text-xl font-semibold mb-2">${d.label.replace(/\n/,' ')}</h2>
      <div class="flex gap-2 mb-3" id="feat-tabs"></div>
      <div id="feat-content" class="text-sm leading-relaxed"></div>
    </div>`);
    const tabs=dash.select('#feat-tabs');
    d.members.forEach((fid,i)=>{
      tabs.append('button').text(fid)   // Feat ${i+1})
        .attr('data-feature',fid)
        .attr('class','px-2 py-1 rounded border text-sm')
        .classed('bg-gray-200',i===0)
        .on('click',ev=>{
          tabs.selectAll('button').classed('bg-gray-200',false);
          d3.select(ev.currentTarget).classed('bg-gray-200',true);
          showFeature(fid);
        });
    });
    showFeature(d.members[0]);
  }else{
    dash.html(`<div class="p-4"><h2 class="text-lg font-semibold mb-2">${d.label}</h2><p class="text-sm">Type: ${d.type}</p></div>`);
  }
  dash.style('display','block');
}

function showFeature(fid){
  // grab whatever metadata you have (might be undefined)
  const f = graphData.features[fid] || {};

  // find the layer from our map
  const layerIdx = featureLayer[fid] || "unknown";

  // extract numeric feature index after the dot
  const featIdx = fid.includes('.') ? fid.split('.')[1] : fid;

  const vizUrl = `https://interprot.com/#/sae-viz/SAE4096-L${layerIdx}/${featIdx}`;

  // now render
  d3.select('#feat-content').html(`
    <h3 class="font-medium mb-1 mt-4">Description</h3>
    <p class="whitespace-pre-line mb-4">${f.description||"No description available."}</p>

    <h3 class="font-medium mb-1 mt-4">Top Activations</h3>
    <p class="whitespace-pre-line mb-4">${f.activations||"N/A"}</p>

    <p class="mt-4">
      <a href="${vizUrl}" target="_blank"
         class="text-indigo-400 underline">
        See InterPro visualizations here
      </a>
    </p>

    <h3 class="font-medium mb-1 mt-4">Figures</h3>
    ${ f.fig1
        ? `<img src="${f.fig1}" class="w-full rounded mb-4 border border-purple-400" />`
        : `<p class="text-sm italic mb-2">No figures defined.</p>`
    }
    ${ f.fig2
        ? `<img src="${f.fig2}" class="w-full rounded mb-4 border border-purple-400" />`
        : ``
    }
    ${ f.fig3
        ? `<img src="${f.fig3}" class="w-full rounded mb-4 border border-purple-400" />`
        : ``
    }
  `);
}

const maxY = Math.max(...graphData.nodes.map(n => n.y)) + 150;
svg.attr('height', maxY);

</script>

</body>
</html>

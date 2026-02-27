const BarChartVisual = @import("bar_chart_visual.zig").BarChartVisual;
const BoxPlotVisual = @import("box_plot_visual.zig").BoxPlotVisual;
const ComboChartVisual = @import("combo_chart_visual.zig").ComboChartVisual;
const CustomContentVisual = @import("custom_content_visual.zig").CustomContentVisual;
const EmptyVisual = @import("empty_visual.zig").EmptyVisual;
const FilledMapVisual = @import("filled_map_visual.zig").FilledMapVisual;
const FunnelChartVisual = @import("funnel_chart_visual.zig").FunnelChartVisual;
const GaugeChartVisual = @import("gauge_chart_visual.zig").GaugeChartVisual;
const GeospatialMapVisual = @import("geospatial_map_visual.zig").GeospatialMapVisual;
const HeatMapVisual = @import("heat_map_visual.zig").HeatMapVisual;
const HistogramVisual = @import("histogram_visual.zig").HistogramVisual;
const InsightVisual = @import("insight_visual.zig").InsightVisual;
const KPIVisual = @import("kpi_visual.zig").KPIVisual;
const LayerMapVisual = @import("layer_map_visual.zig").LayerMapVisual;
const LineChartVisual = @import("line_chart_visual.zig").LineChartVisual;
const PieChartVisual = @import("pie_chart_visual.zig").PieChartVisual;
const PivotTableVisual = @import("pivot_table_visual.zig").PivotTableVisual;
const PluginVisual = @import("plugin_visual.zig").PluginVisual;
const RadarChartVisual = @import("radar_chart_visual.zig").RadarChartVisual;
const SankeyDiagramVisual = @import("sankey_diagram_visual.zig").SankeyDiagramVisual;
const ScatterPlotVisual = @import("scatter_plot_visual.zig").ScatterPlotVisual;
const TableVisual = @import("table_visual.zig").TableVisual;
const TreeMapVisual = @import("tree_map_visual.zig").TreeMapVisual;
const WaterfallVisual = @import("waterfall_visual.zig").WaterfallVisual;
const WordCloudVisual = @import("word_cloud_visual.zig").WordCloudVisual;

/// A visual displayed on a sheet in an analysis, dashboard, or template.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const Visual = struct {
    /// A bar chart.
    ///
    /// For more information, see [Using bar
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/bar-charts.html)
    /// in the *Amazon Quick Suite User Guide*.
    bar_chart_visual: ?BarChartVisual,

    /// A box plot.
    ///
    /// For more information, see [Using box
    /// plots](https://docs.aws.amazon.com/quicksight/latest/user/box-plots.html) in
    /// the *Amazon Quick Suite User Guide*.
    box_plot_visual: ?BoxPlotVisual,

    /// A combo chart.
    ///
    /// For more information, see [Using combo
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/combo-charts.html) in the *Amazon Quick Suite User Guide*.
    combo_chart_visual: ?ComboChartVisual,

    /// A visual that contains custom content.
    ///
    /// For more information, see [Using custom visual
    /// content](https://docs.aws.amazon.com/quicksight/latest/user/custom-visual-content.html) in the *Amazon Quick Suite User Guide*.
    custom_content_visual: ?CustomContentVisual,

    /// An empty visual.
    empty_visual: ?EmptyVisual,

    /// A filled map.
    ///
    /// For more information, see [Creating filled
    /// maps](https://docs.aws.amazon.com/quicksight/latest/user/filled-maps.html)
    /// in the *Amazon Quick Suite User Guide*.
    filled_map_visual: ?FilledMapVisual,

    /// A funnel chart.
    ///
    /// For more information, see [Using funnel
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/funnel-visual-content.html) in the *Amazon Quick Suite User Guide*.
    funnel_chart_visual: ?FunnelChartVisual,

    /// A gauge chart.
    ///
    /// For more information, see [Using gauge
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/gauge-chart.html)
    /// in the *Amazon Quick Suite User Guide*.
    gauge_chart_visual: ?GaugeChartVisual,

    /// A geospatial map or a points on map visual.
    ///
    /// For more information, see [Creating point
    /// maps](https://docs.aws.amazon.com/quicksight/latest/user/point-maps.html) in
    /// the *Amazon Quick Suite User Guide*.
    geospatial_map_visual: ?GeospatialMapVisual,

    /// A heat map.
    ///
    /// For more information, see [Using heat
    /// maps](https://docs.aws.amazon.com/quicksight/latest/user/heat-map.html) in
    /// the *Amazon Quick Suite User Guide*.
    heat_map_visual: ?HeatMapVisual,

    /// A histogram.
    ///
    /// For more information, see [Using
    /// histograms](https://docs.aws.amazon.com/quicksight/latest/user/histogram-charts.html) in the *Amazon Quick Suite User Guide*.
    histogram_visual: ?HistogramVisual,

    /// An insight visual.
    ///
    /// For more information, see [Working with
    /// insights](https://docs.aws.amazon.com/quicksight/latest/user/computational-insights.html) in the *Amazon Quick Suite User Guide*.
    insight_visual: ?InsightVisual,

    /// A key performance indicator (KPI).
    ///
    /// For more information, see [Using
    /// KPIs](https://docs.aws.amazon.com/quicksight/latest/user/kpi.html) in the
    /// *Amazon Quick Suite User Guide*.
    kpi_visual: ?KPIVisual,

    /// The properties for a layer map visual
    layer_map_visual: ?LayerMapVisual,

    /// A line chart.
    ///
    /// For more information, see [Using line
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/line-charts.html)
    /// in the *Amazon Quick Suite User Guide*.
    line_chart_visual: ?LineChartVisual,

    /// A pie or donut chart.
    ///
    /// For more information, see [Using pie
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/pie-chart.html)
    /// in the *Amazon Quick Suite User Guide*.
    pie_chart_visual: ?PieChartVisual,

    /// A pivot table.
    ///
    /// For more information, see [Using pivot
    /// tables](https://docs.aws.amazon.com/quicksight/latest/user/pivot-table.html)
    /// in the *Amazon Quick Suite User Guide*.
    pivot_table_visual: ?PivotTableVisual,

    /// The custom plugin visual type.
    plugin_visual: ?PluginVisual,

    /// A radar chart visual.
    ///
    /// For more information, see [Using radar
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/radar-chart.html)
    /// in the *Amazon Quick Suite User Guide*.
    radar_chart_visual: ?RadarChartVisual,

    /// A sankey diagram.
    ///
    /// For more information, see [Using Sankey
    /// diagrams](https://docs.aws.amazon.com/quicksight/latest/user/sankey-diagram.html) in the *Amazon Quick Suite User Guide*.
    sankey_diagram_visual: ?SankeyDiagramVisual,

    /// A scatter plot.
    ///
    /// For more information, see [Using scatter
    /// plots](https://docs.aws.amazon.com/quicksight/latest/user/scatter-plot.html)
    /// in the *Amazon Quick Suite User Guide*.
    scatter_plot_visual: ?ScatterPlotVisual,

    /// A table visual.
    ///
    /// For more information, see [Using tables as
    /// visuals](https://docs.aws.amazon.com/quicksight/latest/user/tabular.html) in
    /// the *Amazon Quick Suite User Guide*.
    table_visual: ?TableVisual,

    /// A tree map.
    ///
    /// For more information, see [Using tree
    /// maps](https://docs.aws.amazon.com/quicksight/latest/user/tree-map.html) in
    /// the *Amazon Quick Suite User Guide*.
    tree_map_visual: ?TreeMapVisual,

    /// A waterfall chart.
    ///
    /// For more information, see [Using waterfall
    /// charts](https://docs.aws.amazon.com/quicksight/latest/user/waterfall-chart.html) in the *Amazon Quick Suite User Guide*.
    waterfall_visual: ?WaterfallVisual,

    /// A word cloud.
    ///
    /// For more information, see [Using word
    /// clouds](https://docs.aws.amazon.com/quicksight/latest/user/word-cloud.html)
    /// in the *Amazon Quick Suite User Guide*.
    word_cloud_visual: ?WordCloudVisual,

    pub const json_field_names = .{
        .bar_chart_visual = "BarChartVisual",
        .box_plot_visual = "BoxPlotVisual",
        .combo_chart_visual = "ComboChartVisual",
        .custom_content_visual = "CustomContentVisual",
        .empty_visual = "EmptyVisual",
        .filled_map_visual = "FilledMapVisual",
        .funnel_chart_visual = "FunnelChartVisual",
        .gauge_chart_visual = "GaugeChartVisual",
        .geospatial_map_visual = "GeospatialMapVisual",
        .heat_map_visual = "HeatMapVisual",
        .histogram_visual = "HistogramVisual",
        .insight_visual = "InsightVisual",
        .kpi_visual = "KPIVisual",
        .layer_map_visual = "LayerMapVisual",
        .line_chart_visual = "LineChartVisual",
        .pie_chart_visual = "PieChartVisual",
        .pivot_table_visual = "PivotTableVisual",
        .plugin_visual = "PluginVisual",
        .radar_chart_visual = "RadarChartVisual",
        .sankey_diagram_visual = "SankeyDiagramVisual",
        .scatter_plot_visual = "ScatterPlotVisual",
        .table_visual = "TableVisual",
        .tree_map_visual = "TreeMapVisual",
        .waterfall_visual = "WaterfallVisual",
        .word_cloud_visual = "WordCloudVisual",
    };
};

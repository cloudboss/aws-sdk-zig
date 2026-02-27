const aws = @import("aws");

const ExportFilterElement = @import("export_filter_element.zig").ExportFilterElement;

/// This is the top-level field for specifying vertex or edge filters. If the
/// ExportFilter is not provided, then all properties for all labels will be
/// exported. If the ExportFilter is provided but is an empty object, then no
/// data will be exported.
pub const ExportFilter = struct {
    /// Used to specify filters on a per-label basis for edges. This allows you to
    /// control which edge labels and properties are included in the export.
    edge_filter: ?[]const aws.map.MapEntry(ExportFilterElement),

    /// Used to specify filters on a per-label basis for vertices. This allows you
    /// to control which vertex labels and properties are included in the export.
    vertex_filter: ?[]const aws.map.MapEntry(ExportFilterElement),

    pub const json_field_names = .{
        .edge_filter = "edgeFilter",
        .vertex_filter = "vertexFilter",
    };
};

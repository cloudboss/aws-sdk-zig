const Mapping = @import("mapping.zig").Mapping;

/// Specifies a transform that maps data property keys in the data source to
/// data property keys in the data target. You can rename keys, modify the data
/// types for keys, and choose which keys to drop from the dataset.
pub const ApplyMapping = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// Specifies the mapping of data property keys in the data source to data
    /// property keys in the data target.
    mapping: []const Mapping,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .mapping = "Mapping",
        .name = "Name",
    };
};

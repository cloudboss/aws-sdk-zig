/// Specifies a transform that merges a `DynamicFrame` with a staging
/// `DynamicFrame` based on the specified primary keys to identify records.
/// Duplicate records (records with the same primary keys) are not
/// de-duplicated.
pub const Merge = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// The list of primary key fields to match records from the source and staging
    /// dynamic frames.
    primary_keys: []const []const []const u8,

    /// The source `DynamicFrame` that will be merged with a staging `DynamicFrame`.
    source: []const u8,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .primary_keys = "PrimaryKeys",
        .source = "Source",
    };
};

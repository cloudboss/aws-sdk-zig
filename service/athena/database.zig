const aws = @import("aws");

/// Contains metadata information for a database in a data catalog.
pub const Database = struct {
    /// An optional description of the database.
    description: ?[]const u8 = null,

    /// The name of the database.
    name: []const u8,

    /// A set of custom key/value pairs.
    parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .parameters = "Parameters",
    };
};

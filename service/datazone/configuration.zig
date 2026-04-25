const aws = @import("aws");

/// The configuration of a connection.
pub const Configuration = struct {
    /// The classification of the connection configuration.
    classification: ?[]const u8 = null,

    /// The properties of the connection configuration.
    properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .classification = "classification",
        .properties = "properties",
    };
};

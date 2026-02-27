/// The properties that are applied when Infor Nexus is being used as a source.
pub const InforNexusSourceProperties = struct {
    /// The object specified in the Infor Nexus flow source.
    object: []const u8,

    pub const json_field_names = .{
        .object = "object",
    };
};

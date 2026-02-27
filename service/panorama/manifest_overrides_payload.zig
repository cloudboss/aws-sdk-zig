/// Parameter overrides for an application instance. This is a JSON document
/// that has a single key
/// (`PayloadData`) where the value is an escaped string representation of the
/// overrides document.
pub const ManifestOverridesPayload = union(enum) {
    /// The overrides document.
    payload_data: ?[]const u8,

    pub const json_field_names = .{
        .payload_data = "PayloadData",
    };
};

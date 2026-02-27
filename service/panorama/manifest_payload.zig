/// A application verion's manifest file. This is a JSON document that has a
/// single key (`PayloadData`)
/// where the value is an escaped string representation of the application
/// manifest (`graph.json`). This
/// file is located in the `graphs` folder in your application source.
pub const ManifestPayload = union(enum) {
    /// The application manifest.
    payload_data: ?[]const u8,

    pub const json_field_names = .{
        .payload_data = "PayloadData",
    };
};

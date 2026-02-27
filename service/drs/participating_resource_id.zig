/// ID of a resource participating in an asynchronous Job.
pub const ParticipatingResourceID = union(enum) {
    /// Source Network ID.
    source_network_id: ?[]const u8,

    pub const json_field_names = .{
        .source_network_id = "sourceNetworkID",
    };
};

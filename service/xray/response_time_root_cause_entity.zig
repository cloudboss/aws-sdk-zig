/// A collection of segments and corresponding subsegments associated to a
/// response time
/// warning.
pub const ResponseTimeRootCauseEntity = struct {
    /// The type and messages of the exceptions.
    coverage: ?f64,

    /// The name of the entity.
    name: ?[]const u8,

    /// A flag that denotes a remote subsegment.
    remote: ?bool,

    pub const json_field_names = .{
        .coverage = "Coverage",
        .name = "Name",
        .remote = "Remote",
    };
};

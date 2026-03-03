/// Stage plan information such as name, identifier, sub plans, and remote
/// sources.
pub const QueryStagePlanNode = struct {
    /// Stage plan information such as name, identifier, sub plans, and remote
    /// sources of
    /// child plan nodes/
    children: ?[]const QueryStagePlanNode = null,

    /// Information about the operation this query stage plan node is performing.
    identifier: ?[]const u8 = null,

    /// Name of the query stage plan that describes the operation this stage is
    /// performing as
    /// part of query execution.
    name: ?[]const u8 = null,

    /// Source plan node IDs.
    remote_sources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .children = "Children",
        .identifier = "Identifier",
        .name = "Name",
        .remote_sources = "RemoteSources",
    };
};

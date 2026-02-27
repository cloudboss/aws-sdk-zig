/// The identifier for a serverless namespace.
pub const ServerlessIdentifier = struct {
    /// The unique identifier for the serverless namespace.
    namespace_identifier: []const u8,

    /// The unique identifier for the workgroup
    /// associated with the serverless namespace.
    workgroup_identifier: []const u8,
};

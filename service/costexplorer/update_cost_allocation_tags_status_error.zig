/// Gives a detailed description of the result of an action. It's on each cost
/// allocation
/// tag entry in the request.
pub const UpdateCostAllocationTagsStatusError = struct {
    /// An error code representing why the action failed on this entry.
    code: ?[]const u8 = null,

    /// A message explaining why the action failed on this entry.
    message: ?[]const u8 = null,

    /// The key for the cost allocation tag.
    tag_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .tag_key = "TagKey",
    };
};

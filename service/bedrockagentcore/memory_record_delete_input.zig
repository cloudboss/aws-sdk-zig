/// Input structure to delete an existing memory record.
pub const MemoryRecordDeleteInput = struct {
    /// The unique ID of the memory record to be deleted.
    memory_record_id: []const u8,

    /// The namespace of the memory record being deleted. This value is used for IAM
    /// condition key authorization.
    namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .memory_record_id = "memoryRecordId",
        .namespace = "namespace",
    };
};

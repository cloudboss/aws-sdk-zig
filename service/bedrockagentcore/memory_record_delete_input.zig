/// Input structure to delete an existing memory record.
pub const MemoryRecordDeleteInput = struct {
    /// The unique ID of the memory record to be deleted.
    memory_record_id: []const u8,

    pub const json_field_names = .{
        .memory_record_id = "memoryRecordId",
    };
};

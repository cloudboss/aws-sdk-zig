/// Information on the records ingested by this request.
pub const RecordsIngested = struct {
    /// Count of records ingested into the magnetic store.
    magnetic_store: i32 = 0,

    /// Count of records ingested into the memory store.
    memory_store: i32 = 0,

    /// Total count of successfully ingested records.
    total: i32 = 0,

    pub const json_field_names = .{
        .magnetic_store = "MagneticStore",
        .memory_store = "MemoryStore",
        .total = "Total",
    };
};

/// The memory size configurations of a container.
pub const MemorySizeConfiguration = struct {
    /// The amount of memory in the container.
    memory: ?i32,

    /// The limit of memory reserve for the container.
    memory_reservation: ?i32,

    pub const json_field_names = .{
        .memory = "memory",
        .memory_reservation = "memoryReservation",
    };
};

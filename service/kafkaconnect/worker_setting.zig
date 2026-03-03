const CapacityDescription = @import("capacity_description.zig").CapacityDescription;

/// Details about worker setting of a connector
pub const WorkerSetting = struct {
    capacity: ?CapacityDescription = null,

    pub const json_field_names = .{
        .capacity = "capacity",
    };
};

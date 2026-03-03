/// The allowable range of vCPU processing power for the fleet.
pub const VCpuCountRange = struct {
    /// The maximum amount of vCPU.
    max: ?i32 = null,

    /// The minimum amount of vCPU.
    min: i32,

    pub const json_field_names = .{
        .max = "max",
        .min = "min",
    };
};

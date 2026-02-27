const CpuCreditsEnum = @import("cpu_credits_enum.zig").CpuCreditsEnum;

/// Defines CPU credit configuration for burstable instances.
pub const CreditSpecificationRequest = struct {
    /// CPU credit specification mode.
    cpu_credits: ?CpuCreditsEnum,

    pub const json_field_names = .{
        .cpu_credits = "CpuCredits",
    };
};

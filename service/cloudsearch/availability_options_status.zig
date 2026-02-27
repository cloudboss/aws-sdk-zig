const OptionStatus = @import("option_status.zig").OptionStatus;

/// The status and configuration of the domain's availability options.
pub const AvailabilityOptionsStatus = struct {
    /// The availability options configured for the domain.
    options: bool = false,

    status: OptionStatus,
};

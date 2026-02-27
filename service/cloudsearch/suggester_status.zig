const Suggester = @import("suggester.zig").Suggester;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The value of a `Suggester` and its current status.
pub const SuggesterStatus = struct {
    options: Suggester,

    status: OptionStatus,
};

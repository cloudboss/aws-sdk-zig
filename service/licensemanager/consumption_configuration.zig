const BorrowConfiguration = @import("borrow_configuration.zig").BorrowConfiguration;
const ProvisionalConfiguration = @import("provisional_configuration.zig").ProvisionalConfiguration;
const RenewType = @import("renew_type.zig").RenewType;

/// Details about a consumption configuration.
pub const ConsumptionConfiguration = struct {
    /// Details about a borrow configuration.
    borrow_configuration: ?BorrowConfiguration = null,

    /// Details about a provisional configuration.
    provisional_configuration: ?ProvisionalConfiguration = null,

    /// Renewal frequency.
    renew_type: ?RenewType = null,

    pub const json_field_names = .{
        .borrow_configuration = "BorrowConfiguration",
        .provisional_configuration = "ProvisionalConfiguration",
        .renew_type = "RenewType",
    };
};

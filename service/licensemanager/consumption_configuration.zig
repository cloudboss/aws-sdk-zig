const BorrowConfiguration = @import("borrow_configuration.zig").BorrowConfiguration;
const ProvisionalConfiguration = @import("provisional_configuration.zig").ProvisionalConfiguration;
const RenewType = @import("renew_type.zig").RenewType;

/// Details about a consumption configuration.
pub const ConsumptionConfiguration = struct {
    /// Details about a borrow configuration.
    borrow_configuration: ?BorrowConfiguration,

    /// Details about a provisional configuration.
    provisional_configuration: ?ProvisionalConfiguration,

    /// Renewal frequency.
    renew_type: ?RenewType,

    pub const json_field_names = .{
        .borrow_configuration = "BorrowConfiguration",
        .provisional_configuration = "ProvisionalConfiguration",
        .renew_type = "RenewType",
    };
};

const ValidateAddressActionOptions = @import("validate_address_action_options.zig").ValidateAddressActionOptions;

/// Additional options for configuring job action parameters.
pub const JobActionOptions = struct {
    /// Options specific to address validation jobs.
    validate_address: ?ValidateAddressActionOptions = null,

    pub const json_field_names = .{
        .validate_address = "ValidateAddress",
    };
};

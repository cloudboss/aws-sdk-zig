pub const PaymentRequestApprovalStrategy = enum {
    auto_approve_on_expiration,
    wait_for_approval,

    pub const json_field_names = .{
        .auto_approve_on_expiration = "AUTO_APPROVE_ON_EXPIRATION",
        .wait_for_approval = "WAIT_FOR_APPROVAL",
    };
};

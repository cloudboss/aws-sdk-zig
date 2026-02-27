/// The sending status for a reputation entity. This can be one of the
/// following:
///
/// * `ENABLED` – Sending is allowed for this entity.
///
/// * `DISABLED` – Sending is prevented for this entity.
///
/// * `REINSTATED` – Sending is allowed even if there are active reputation
///   findings.
pub const SendingStatus = enum {
    enabled,
    reinstated,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .reinstated = "REINSTATED",
        .disabled = "DISABLED",
    };
};

/// Describes Challenge-Handshake Authentication Protocol (CHAP) information
/// that supports
/// authentication between your gateway and iSCSI initiators.
pub const ChapInfo = struct {
    /// The iSCSI initiator that connects to the target.
    initiator_name: ?[]const u8,

    /// The secret key that the initiator (for example, the Windows client) must
    /// provide to
    /// participate in mutual CHAP with the target.
    secret_to_authenticate_initiator: ?[]const u8,

    /// The secret key that the target must provide to participate in mutual CHAP
    /// with the
    /// initiator (e.g., Windows client).
    secret_to_authenticate_target: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the volume.
    ///
    /// Valid Values: 50 to 500 lowercase letters, numbers, periods (.), and hyphens
    /// (-).
    target_arn: ?[]const u8,

    pub const json_field_names = .{
        .initiator_name = "InitiatorName",
        .secret_to_authenticate_initiator = "SecretToAuthenticateInitiator",
        .secret_to_authenticate_target = "SecretToAuthenticateTarget",
        .target_arn = "TargetARN",
    };
};

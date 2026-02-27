/// The type of device transfer. INCOMING for an input device that is being
/// transferred to you, OUTGOING for an input device that you are transferring
/// to another AWS account.
pub const InputDeviceTransferType = enum {
    outgoing,
    incoming,

    pub const json_field_names = .{
        .outgoing = "OUTGOING",
        .incoming = "INCOMING",
    };
};

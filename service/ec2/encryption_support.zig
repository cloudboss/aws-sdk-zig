const EncryptionStateValue = @import("encryption_state_value.zig").EncryptionStateValue;

/// Describes the encryption support status for a transit gateway.
pub const EncryptionSupport = struct {
    /// The current encryption state of the resource.
    encryption_state: ?EncryptionStateValue,

    /// A message describing the encryption state.
    state_message: ?[]const u8,
};

const Tag = @import("tag.zig").Tag;
const User = @import("user.zig").User;

/// Contains information about a virtual MFA device.
pub const VirtualMFADevice = struct {
    /// The base32 seed defined as specified in
    /// [RFC3548](https://tools.ietf.org/html/rfc3548.txt). The `Base32StringSeed`
    /// is base32-encoded.
    base_32_string_seed: ?[]const u8 = null,

    /// The date and time on which the virtual MFA device was enabled.
    enable_date: ?i64 = null,

    /// A QR code PNG image that encodes
    /// `otpauth://totp/$virtualMFADeviceName@$AccountName?secret=$Base32String`
    /// where `$virtualMFADeviceName` is one of the create call arguments.
    /// `AccountName` is the user name if set (otherwise, the account ID otherwise),
    /// and `Base32String` is the seed in base32 format. The `Base32String`
    /// value is base64-encoded.
    qr_code_png: ?[]const u8 = null,

    /// The serial number associated with `VirtualMFADevice`.
    serial_number: []const u8,

    /// A list of tags that are attached to the virtual MFA device. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,

    /// The IAM user associated with this virtual MFA device.
    user: ?User = null,
};

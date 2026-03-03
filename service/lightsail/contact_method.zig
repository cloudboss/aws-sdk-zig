const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ContactProtocol = @import("contact_protocol.zig").ContactProtocol;
const ResourceType = @import("resource_type.zig").ResourceType;
const ContactMethodStatus = @import("contact_method_status.zig").ContactMethodStatus;

/// Describes a contact method.
///
/// A contact method is a way to send you notifications. For more information,
/// see [Notifications in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-notifications).
pub const ContactMethod = struct {
    /// The Amazon Resource Name (ARN) of the contact method.
    arn: ?[]const u8 = null,

    /// The destination of the contact method, such as an email address or a mobile
    /// phone
    /// number.
    contact_endpoint: ?[]const u8 = null,

    /// The timestamp when the contact method was created.
    created_at: ?i64 = null,

    /// An object that describes the location of the contact method, such as the
    /// Amazon Web Services Region and Availability Zone.
    location: ?ResourceLocation = null,

    /// The name of the contact method.
    name: ?[]const u8 = null,

    /// The protocol of the contact method, such as email or SMS (text messaging).
    protocol: ?ContactProtocol = null,

    /// The Lightsail resource type of the contact method.
    resource_type: ?ResourceType = null,

    /// The current status of the contact method.
    ///
    /// A contact method has the following possible status:
    ///
    /// * `PendingVerification` - The contact method has not yet been verified, and
    /// the verification has not yet expired.
    ///
    /// * `Valid` - The contact method has been verified.
    ///
    /// * `InValid` - An attempt was made to verify the contact method, but the
    /// verification has expired.
    status: ?ContactMethodStatus = null,

    /// The support code. Include this code in your email to support when you have
    /// questions about
    /// your Lightsail contact method. This code enables our support team to look up
    /// your
    /// Lightsail information more easily.
    support_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .contact_endpoint = "contactEndpoint",
        .created_at = "createdAt",
        .location = "location",
        .name = "name",
        .protocol = "protocol",
        .resource_type = "resourceType",
        .status = "status",
        .support_code = "supportCode",
    };
};

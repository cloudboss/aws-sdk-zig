/// Send OTP message request parameters.
pub const SendOTPMessageRequestParameters = struct {
    /// The attempts allowed to validate an OTP.
    allowed_attempts: ?i32,

    /// The brand name that will be substituted into the OTP message body. Should be
    /// owned by calling AWS account.
    brand_name: []const u8,

    /// Channel type for the OTP message. Supported values: [SMS].
    channel: []const u8,

    /// The number of characters in the generated OTP.
    code_length: ?i32,

    /// The destination identity to send OTP to.
    destination_identity: []const u8,

    /// A unique Entity ID received from DLT after entity registration is approved.
    entity_id: ?[]const u8,

    /// The language to be used for the outgoing message body containing the OTP.
    language: ?[]const u8,

    /// The origination identity used to send OTP from.
    origination_identity: []const u8,

    /// Developer-specified reference identifier. Required to match during OTP
    /// verification.
    reference_id: []const u8,

    /// A unique Template ID received from DLT after entity registration is
    /// approved.
    template_id: ?[]const u8,

    /// The time in minutes before the OTP is no longer valid.
    validity_period: ?i32,

    pub const json_field_names = .{
        .allowed_attempts = "AllowedAttempts",
        .brand_name = "BrandName",
        .channel = "Channel",
        .code_length = "CodeLength",
        .destination_identity = "DestinationIdentity",
        .entity_id = "EntityId",
        .language = "Language",
        .origination_identity = "OriginationIdentity",
        .reference_id = "ReferenceId",
        .template_id = "TemplateId",
        .validity_period = "ValidityPeriod",
    };
};

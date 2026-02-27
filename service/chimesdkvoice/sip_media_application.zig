const SipMediaApplicationEndpoint = @import("sip_media_application_endpoint.zig").SipMediaApplicationEndpoint;

/// The details of the SIP media application, including name and endpoints.
/// An AWS account can have multiple SIP media applications.
pub const SipMediaApplication = struct {
    /// The AWS Region in which the SIP media application is created.
    aws_region: ?[]const u8,

    /// The SIP media application creation timestamp, in ISO 8601 format.
    created_timestamp: ?i64,

    /// List of endpoints for a SIP media application. Currently, only one endpoint
    /// per
    /// SIP media application is permitted.
    endpoints: ?[]const SipMediaApplicationEndpoint,

    /// The SIP media application's name.
    name: ?[]const u8,

    /// The ARN of the SIP media application.
    sip_media_application_arn: ?[]const u8,

    /// A SIP media application's ID.
    sip_media_application_id: ?[]const u8,

    /// The time at which the SIP media application was updated.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .created_timestamp = "CreatedTimestamp",
        .endpoints = "Endpoints",
        .name = "Name",
        .sip_media_application_arn = "SipMediaApplicationArn",
        .sip_media_application_id = "SipMediaApplicationId",
        .updated_timestamp = "UpdatedTimestamp",
    };
};

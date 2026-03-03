const std = @import("std");

/// The mode of authentication for a server. The default value is
/// `SERVICE_MANAGED`, which allows you to store and access user credentials
/// within the Transfer Family service.
///
/// Use `AWS_DIRECTORY_SERVICE` to provide access to Active Directory groups in
/// Directory Service for Microsoft Active Directory or Microsoft Active
/// Directory in your on-premises environment or in Amazon Web Services using AD
/// Connector. This option also requires you to provide a Directory ID by using
/// the `IdentityProviderDetails` parameter.
///
/// Use the `API_GATEWAY` value to integrate with an identity provider of your
/// choosing. The `API_GATEWAY` setting requires you to provide an Amazon API
/// Gateway endpoint URL to call for authentication by using the
/// `IdentityProviderDetails` parameter.
///
/// Use the `AWS_LAMBDA` value to directly use an Lambda function as your
/// identity provider. If you choose this value, you must specify the ARN for
/// the Lambda function in the `Function` parameter for the
/// `IdentityProviderDetails` data type.
pub const IdentityProviderType = enum {
    service_managed,
    api_gateway,
    aws_directory_service,
    aws_lambda,

    pub const json_field_names = .{
        .service_managed = "SERVICE_MANAGED",
        .api_gateway = "API_GATEWAY",
        .aws_directory_service = "AWS_DIRECTORY_SERVICE",
        .aws_lambda = "AWS_LAMBDA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_managed => "SERVICE_MANAGED",
            .api_gateway => "API_GATEWAY",
            .aws_directory_service => "AWS_DIRECTORY_SERVICE",
            .aws_lambda => "AWS_LAMBDA",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

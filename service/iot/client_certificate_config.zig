/// An object that speciﬁes the client certificate conﬁguration for a domain.
pub const ClientCertificateConfig = struct {
    /// The ARN of the Lambda function that IoT invokes after mutual TLS
    /// authentication during the connection.
    client_certificate_callback_arn: ?[]const u8,

    pub const json_field_names = .{
        .client_certificate_callback_arn = "clientCertificateCallbackArn",
    };
};

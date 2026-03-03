/// The server certificate configuration.
pub const ServerCertificateConfig = struct {
    /// A Boolean value that indicates whether Online Certificate Status Protocol
    /// (OCSP) server
    /// certificate check is enabled or not.
    ///
    /// For more information, see [
    /// Server certificate configuration for OCSP
    /// stapling](https://docs.aws.amazon.com/iot/latest/developerguide/iot-custom-endpoints-cert-config.html) from Amazon Web Services IoT Core Developer Guide.
    enable_ocsp_check: ?bool = null,

    /// The Amazon Resource Name (ARN) for an X.509 certificate stored in Amazon Web
    /// Services Certificate
    /// Manager (ACM). If provided, Amazon Web Services IoT Core will use this
    /// certificate to validate the signature
    /// of the received OCSP response. The OCSP responder must sign responses using
    /// either this
    /// authorized responder certificate or the issuing certificate, depending on
    /// whether the ARN
    /// is provided or not. The certificate must be in the same Amazon Web Services
    /// account and region as the
    /// domain configuration.
    ocsp_authorized_responder_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for a Lambda function that acts as a Request
    /// for Comments
    /// (RFC) 6960-compliant Online Certificate Status Protocol (OCSP) responder,
    /// supporting basic
    /// OCSP responses. The Lambda function accepts a base64-encoding of the OCSP
    /// request in the
    /// Distinguished Encoding Rules (DER) format. The Lambda function's response is
    /// also a
    /// base64-encoded OCSP response in the DER format. The response size must not
    /// exceed 4
    /// kilobytes (KiB). The Lambda function must be in the same Amazon Web Services
    /// account and region as the
    /// domain configuration. For more information, see [Configuring server
    /// certificate OCSP for private endpoints in Amazon Web Services IoT
    /// Core](https://docs.aws.amazon.com/iot/latest/developerguide/iot-custom-endpoints-cert-config.html#iot-custom-endpoints-cert-config-ocsp-private-endpoint.html) from the
    /// Amazon Web Services IoT Core developer guide.
    ocsp_lambda_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .enable_ocsp_check = "enableOCSPCheck",
        .ocsp_authorized_responder_arn = "ocspAuthorizedResponderArn",
        .ocsp_lambda_arn = "ocspLambdaArn",
    };
};

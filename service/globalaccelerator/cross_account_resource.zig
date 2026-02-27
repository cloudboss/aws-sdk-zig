/// An endpoint (Amazon Web Services resource) or an IP address range, in CIDR
/// format, that is
/// listed in a cross-account attachment. A cross-account resource can be added
/// to an accelerator by
/// specified principals, which are also listed in the attachment.
///
/// For more information, see [
/// Working with cross-account attachments and resources in Global
/// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/cross-account-resources.html) in the *
/// Global Accelerator Developer Guide*.
pub const CrossAccountResource = struct {
    /// The Amazon Resource Name (ARN) of the cross-account attachment that
    /// specifies the resources (endpoints or
    /// CIDR range) that can be added to accelerators and principals that have
    /// permission to add them.
    attachment_arn: ?[]const u8,

    /// An IP address range, in CIDR format, that is specified as an Amazon Web
    /// Services resource. The address must
    /// be provisioned and advertised in Global Accelerator by following the bring
    /// your own IP address (BYOIP) process
    /// for Global Accelerator.
    ///
    /// For more information, see
    /// [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in
    /// the Global Accelerator Developer Guide.
    cidr: ?[]const u8,

    /// The endpoint ID for the endpoint that is listed in a cross-account
    /// attachment and
    /// can be added to an accelerator by specified principals.
    endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .attachment_arn = "AttachmentArn",
        .cidr = "Cidr",
        .endpoint_id = "EndpointId",
    };
};

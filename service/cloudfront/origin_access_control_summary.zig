const OriginAccessControlOriginTypes = @import("origin_access_control_origin_types.zig").OriginAccessControlOriginTypes;
const OriginAccessControlSigningBehaviors = @import("origin_access_control_signing_behaviors.zig").OriginAccessControlSigningBehaviors;
const OriginAccessControlSigningProtocols = @import("origin_access_control_signing_protocols.zig").OriginAccessControlSigningProtocols;

/// A CloudFront origin access control.
pub const OriginAccessControlSummary = struct {
    /// A description of the origin access control.
    description: []const u8,

    /// The unique identifier of the origin access control.
    id: []const u8,

    /// A unique name that identifies the origin access control.
    name: []const u8,

    /// The type of origin that this origin access control is for.
    origin_access_control_origin_type: OriginAccessControlOriginTypes,

    /// A value that specifies which requests CloudFront signs (adds authentication
    /// information to). This field can have one of the following values:
    ///
    /// * `never` – CloudFront doesn't sign any origin requests.
    /// * `always` – CloudFront signs all origin requests, overwriting the
    ///   `Authorization` header from the viewer request if necessary.
    /// * `no-override` – If the viewer request doesn't contain the `Authorization`
    ///   header, CloudFront signs the origin request. If the viewer request
    ///   contains the `Authorization` header, CloudFront doesn't sign the origin
    ///   request, but instead passes along the `Authorization` header that it
    ///   received in the viewer request.
    signing_behavior: OriginAccessControlSigningBehaviors,

    /// The signing protocol of the origin access control. The signing protocol
    /// determines how CloudFront signs (authenticates) requests. The only valid
    /// value is `sigv4`.
    signing_protocol: OriginAccessControlSigningProtocols,
};

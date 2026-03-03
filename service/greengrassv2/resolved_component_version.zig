const VendorGuidance = @import("vendor_guidance.zig").VendorGuidance;

/// Contains information about a component version that is compatible to run on
/// a Greengrass core
/// device.
pub const ResolvedComponentVersion = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8 = null,

    /// The name of the component.
    component_name: ?[]const u8 = null,

    /// The version of the component.
    component_version: ?[]const u8 = null,

    /// A message that communicates details about the vendor guidance state
    /// of the component version. This message communicates why a component version
    /// is discontinued or deleted.
    message: ?[]const u8 = null,

    /// The recipe of the component version.
    recipe: ?[]const u8 = null,

    /// The vendor guidance state for the component version. This state indicates
    /// whether
    /// the component version has any issues that you should consider before you
    /// deploy it. The vendor guidance state can be:
    ///
    /// * `ACTIVE` – This component version is available and recommended for use.
    ///
    /// * `DISCONTINUED` – This component version has been discontinued by its
    ///   publisher.
    /// You can deploy this component version, but we recommend that you use a
    /// different version of this component.
    ///
    /// * `DELETED` – This component version has been deleted by its publisher, so
    ///   you can't
    /// deploy it. If you have any existing deployments that specify this component
    /// version, those deployments will fail.
    vendor_guidance: ?VendorGuidance = null,

    pub const json_field_names = .{
        .arn = "arn",
        .component_name = "componentName",
        .component_version = "componentVersion",
        .message = "message",
        .recipe = "recipe",
        .vendor_guidance = "vendorGuidance",
    };
};

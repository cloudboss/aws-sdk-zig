const aws = @import("aws");

const CloudComponentState = @import("cloud_component_state.zig").CloudComponentState;
const VendorGuidance = @import("vendor_guidance.zig").VendorGuidance;

/// Contains the status of a component version in the IoT Greengrass service.
pub const CloudComponentStatus = struct {
    /// The state of the component version.
    component_state: ?CloudComponentState,

    /// A dictionary of errors that communicate why the component version is in an
    /// error state.
    /// For example, if IoT Greengrass can't access an artifact for the component
    /// version, then
    /// `errors` contains the artifact's URI as a key, and the error message as the
    /// value
    /// for that key.
    errors: ?[]const aws.map.StringMapEntry,

    /// A message that communicates details, such as errors, about the status of the
    /// component
    /// version.
    message: ?[]const u8,

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
    vendor_guidance: ?VendorGuidance,

    /// A message that communicates details about the vendor guidance state
    /// of the component version. This message communicates why a component version
    /// is discontinued or deleted.
    vendor_guidance_message: ?[]const u8,

    pub const json_field_names = .{
        .component_state = "componentState",
        .errors = "errors",
        .message = "message",
        .vendor_guidance = "vendorGuidance",
        .vendor_guidance_message = "vendorGuidanceMessage",
    };
};

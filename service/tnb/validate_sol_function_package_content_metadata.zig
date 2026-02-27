const FunctionArtifactMeta = @import("function_artifact_meta.zig").FunctionArtifactMeta;

/// Validates function package content metadata.
///
/// A function package is a .zip file in CSAR (Cloud Service Archive) format
/// that contains a network function (an ETSI standard telecommunication
/// application) and function package descriptor that uses the TOSCA standard to
/// describe how the network functions should run on your network.
pub const ValidateSolFunctionPackageContentMetadata = struct {
    vnfd: ?FunctionArtifactMeta,

    pub const json_field_names = .{
        .vnfd = "vnfd",
    };
};

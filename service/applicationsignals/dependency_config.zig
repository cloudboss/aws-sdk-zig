const aws = @import("aws");

/// Identifies the dependency using the `DependencyKeyAttributes` and
/// `DependencyOperationName`.
///
/// When creating a service dependency SLO, you must specify the `KeyAttributes`
/// of the service, and the `DependencyConfig` for the dependency. You can
/// specify the `OperationName` of the service, from which it calls the
/// dependency. Alternatively, you can exclude `OperationName` and the SLO will
/// monitor all of the service's operations that call the dependency.
pub const DependencyConfig = struct {
    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    dependency_key_attributes: []const aws.map.StringMapEntry,

    /// The name of the called operation in the dependency.
    dependency_operation_name: []const u8,

    pub const json_field_names = .{
        .dependency_key_attributes = "DependencyKeyAttributes",
        .dependency_operation_name = "DependencyOperationName",
    };
};

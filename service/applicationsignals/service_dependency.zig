const aws = @import("aws");

const MetricReference = @import("metric_reference.zig").MetricReference;

/// This structure contains information about one dependency of this service.
pub const ServiceDependency = struct {
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

    /// An array of structures that each contain information about one metric
    /// associated with this service dependency that was discovered by Application
    /// Signals.
    metric_references: []const MetricReference,

    /// The name of the operation in this service that calls the dependency.
    operation_name: []const u8,

    pub const json_field_names = .{
        .dependency_key_attributes = "DependencyKeyAttributes",
        .dependency_operation_name = "DependencyOperationName",
        .metric_references = "MetricReferences",
        .operation_name = "OperationName",
    };
};

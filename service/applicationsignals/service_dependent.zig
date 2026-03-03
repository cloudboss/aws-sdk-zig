const aws = @import("aws");

const MetricReference = @import("metric_reference.zig").MetricReference;

/// This structure contains information about a service dependent that was
/// discovered by Application Signals. A dependent is an entity that invoked the
/// specified service during the provided time range. Dependents include other
/// services, CloudWatch Synthetics canaries, and clients that are instrumented
/// with CloudWatch RUM app monitors.
pub const ServiceDependent = struct {
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
    dependent_key_attributes: []const aws.map.StringMapEntry,

    /// If the dependent invoker was a service that invoked it from an operation,
    /// the name of that dependent operation is displayed here.
    dependent_operation_name: ?[]const u8 = null,

    /// An array of structures that each contain information about one metric
    /// associated with this service dependent that was discovered by Application
    /// Signals.
    metric_references: []const MetricReference,

    /// If the invoked entity is an operation on an entity, the name of that
    /// dependent operation is displayed here.
    operation_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .dependent_key_attributes = "DependentKeyAttributes",
        .dependent_operation_name = "DependentOperationName",
        .metric_references = "MetricReferences",
        .operation_name = "OperationName",
    };
};

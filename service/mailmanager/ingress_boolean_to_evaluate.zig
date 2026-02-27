const IngressAnalysis = @import("ingress_analysis.zig").IngressAnalysis;
const IngressIsInAddressList = @import("ingress_is_in_address_list.zig").IngressIsInAddressList;

/// The union type representing the allowed types of operands for a boolean
/// condition.
pub const IngressBooleanToEvaluate = union(enum) {
    /// The structure type for a boolean condition stating the Add On ARN and its
    /// returned value.
    analysis: ?IngressAnalysis,
    /// The structure type for a boolean condition that provides the address lists
    /// to evaluate incoming traffic on.
    is_in_address_list: ?IngressIsInAddressList,

    pub const json_field_names = .{
        .analysis = "Analysis",
        .is_in_address_list = "IsInAddressList",
    };
};

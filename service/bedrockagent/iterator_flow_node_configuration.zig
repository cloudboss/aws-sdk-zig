/// Contains configurations for an iterator node in a flow. Takes an input that
/// is an array and iteratively sends each item of the array as an output to the
/// following node. The size of the array is also returned in the output.
///
/// The output flow node at the end of the flow iteration will return a response
/// for each member of the array. To return only one response, you can include a
/// collector node downstream from the iterator node.
pub const IteratorFlowNodeConfiguration = struct {};

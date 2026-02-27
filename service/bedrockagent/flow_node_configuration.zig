const AgentFlowNodeConfiguration = @import("agent_flow_node_configuration.zig").AgentFlowNodeConfiguration;
const CollectorFlowNodeConfiguration = @import("collector_flow_node_configuration.zig").CollectorFlowNodeConfiguration;
const ConditionFlowNodeConfiguration = @import("condition_flow_node_configuration.zig").ConditionFlowNodeConfiguration;
const InlineCodeFlowNodeConfiguration = @import("inline_code_flow_node_configuration.zig").InlineCodeFlowNodeConfiguration;
const InputFlowNodeConfiguration = @import("input_flow_node_configuration.zig").InputFlowNodeConfiguration;
const IteratorFlowNodeConfiguration = @import("iterator_flow_node_configuration.zig").IteratorFlowNodeConfiguration;
const KnowledgeBaseFlowNodeConfiguration = @import("knowledge_base_flow_node_configuration.zig").KnowledgeBaseFlowNodeConfiguration;
const LambdaFunctionFlowNodeConfiguration = @import("lambda_function_flow_node_configuration.zig").LambdaFunctionFlowNodeConfiguration;
const LexFlowNodeConfiguration = @import("lex_flow_node_configuration.zig").LexFlowNodeConfiguration;
const LoopFlowNodeConfiguration = @import("loop_flow_node_configuration.zig").LoopFlowNodeConfiguration;
const LoopControllerFlowNodeConfiguration = @import("loop_controller_flow_node_configuration.zig").LoopControllerFlowNodeConfiguration;
const LoopInputFlowNodeConfiguration = @import("loop_input_flow_node_configuration.zig").LoopInputFlowNodeConfiguration;
const OutputFlowNodeConfiguration = @import("output_flow_node_configuration.zig").OutputFlowNodeConfiguration;
const PromptFlowNodeConfiguration = @import("prompt_flow_node_configuration.zig").PromptFlowNodeConfiguration;
const RetrievalFlowNodeConfiguration = @import("retrieval_flow_node_configuration.zig").RetrievalFlowNodeConfiguration;
const StorageFlowNodeConfiguration = @import("storage_flow_node_configuration.zig").StorageFlowNodeConfiguration;

/// Contains configurations for a node in your flow. For more information, see
/// [Node types in a
/// flow](https://docs.aws.amazon.com/bedrock/latest/userguide/flows-nodes.html)
/// in the Amazon Bedrock User Guide.
pub const FlowNodeConfiguration = union(enum) {
    /// Contains configurations for an agent node in your flow. Invokes an alias of
    /// an agent and returns the response.
    agent: ?AgentFlowNodeConfiguration,
    /// Contains configurations for a collector node in your flow. Collects an
    /// iteration of inputs and consolidates them into an array of outputs.
    collector: ?CollectorFlowNodeConfiguration,
    /// Contains configurations for a condition node in your flow. Defines
    /// conditions that lead to different branches of the flow.
    condition: ?ConditionFlowNodeConfiguration,
    /// Contains configurations for an inline code node in your flow. Inline code
    /// nodes let you write and execute code directly within your flow, enabling
    /// data transformations, custom logic, and integrations without needing an
    /// external Lambda function.
    inline_code: ?InlineCodeFlowNodeConfiguration,
    /// Contains configurations for an input flow node in your flow. The first node
    /// in the flow. `inputs` can't be specified for this node.
    input: ?InputFlowNodeConfiguration,
    /// Contains configurations for an iterator node in your flow. Takes an input
    /// that is an array and iteratively sends each item of the array as an output
    /// to the following node. The size of the array is also returned in the output.
    ///
    /// The output flow node at the end of the flow iteration will return a response
    /// for each member of the array. To return only one response, you can include a
    /// collector node downstream from the iterator node.
    iterator: ?IteratorFlowNodeConfiguration,
    /// Contains configurations for a knowledge base node in your flow. Queries a
    /// knowledge base and returns the retrieved results or generated response.
    knowledge_base: ?KnowledgeBaseFlowNodeConfiguration,
    /// Contains configurations for a Lambda function node in your flow. Invokes an
    /// Lambda function.
    lambda_function: ?LambdaFunctionFlowNodeConfiguration,
    /// Contains configurations for a Lex node in your flow. Invokes an Amazon Lex
    /// bot to identify the intent of the input and return the intent as the output.
    lex: ?LexFlowNodeConfiguration,
    /// Contains configurations for a DoWhile loop in your flow.
    loop: ?LoopFlowNodeConfiguration,
    /// Contains controller node configurations for a DoWhile loop in your flow.
    loop_controller: ?LoopControllerFlowNodeConfiguration,
    /// Contains input node configurations for a DoWhile loop in your flow.
    loop_input: ?LoopInputFlowNodeConfiguration,
    /// Contains configurations for an output flow node in your flow. The last node
    /// in the flow. `outputs` can't be specified for this node.
    output: ?OutputFlowNodeConfiguration,
    /// Contains configurations for a prompt node in your flow. Runs a prompt and
    /// generates the model response as the output. You can use a prompt from Prompt
    /// management or you can configure one in this node.
    prompt: ?PromptFlowNodeConfiguration,
    /// Contains configurations for a retrieval node in your flow. Retrieves data
    /// from an Amazon S3 location and returns it as the output.
    retrieval: ?RetrievalFlowNodeConfiguration,
    /// Contains configurations for a storage node in your flow. Stores an input in
    /// an Amazon S3 location.
    storage: ?StorageFlowNodeConfiguration,

    pub const json_field_names = .{
        .agent = "agent",
        .collector = "collector",
        .condition = "condition",
        .inline_code = "inlineCode",
        .input = "input",
        .iterator = "iterator",
        .knowledge_base = "knowledgeBase",
        .lambda_function = "lambdaFunction",
        .lex = "lex",
        .loop = "loop",
        .loop_controller = "loopController",
        .loop_input = "loopInput",
        .output = "output",
        .prompt = "prompt",
        .retrieval = "retrieval",
        .storage = "storage",
    };
};

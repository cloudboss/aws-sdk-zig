const aws = @import("aws");
const std = @import("std");

const cancel_image_creation = @import("cancel_image_creation.zig");
const cancel_lifecycle_execution = @import("cancel_lifecycle_execution.zig");
const create_component = @import("create_component.zig");
const create_container_recipe = @import("create_container_recipe.zig");
const create_distribution_configuration = @import("create_distribution_configuration.zig");
const create_image = @import("create_image.zig");
const create_image_pipeline = @import("create_image_pipeline.zig");
const create_image_recipe = @import("create_image_recipe.zig");
const create_infrastructure_configuration = @import("create_infrastructure_configuration.zig");
const create_lifecycle_policy = @import("create_lifecycle_policy.zig");
const create_workflow = @import("create_workflow.zig");
const delete_component = @import("delete_component.zig");
const delete_container_recipe = @import("delete_container_recipe.zig");
const delete_distribution_configuration = @import("delete_distribution_configuration.zig");
const delete_image = @import("delete_image.zig");
const delete_image_pipeline = @import("delete_image_pipeline.zig");
const delete_image_recipe = @import("delete_image_recipe.zig");
const delete_infrastructure_configuration = @import("delete_infrastructure_configuration.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const delete_workflow = @import("delete_workflow.zig");
const distribute_image = @import("distribute_image.zig");
const get_component = @import("get_component.zig");
const get_component_policy = @import("get_component_policy.zig");
const get_container_recipe = @import("get_container_recipe.zig");
const get_container_recipe_policy = @import("get_container_recipe_policy.zig");
const get_distribution_configuration = @import("get_distribution_configuration.zig");
const get_image = @import("get_image.zig");
const get_image_pipeline = @import("get_image_pipeline.zig");
const get_image_policy = @import("get_image_policy.zig");
const get_image_recipe = @import("get_image_recipe.zig");
const get_image_recipe_policy = @import("get_image_recipe_policy.zig");
const get_infrastructure_configuration = @import("get_infrastructure_configuration.zig");
const get_lifecycle_execution = @import("get_lifecycle_execution.zig");
const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
const get_marketplace_resource = @import("get_marketplace_resource.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_execution = @import("get_workflow_execution.zig");
const get_workflow_step_execution = @import("get_workflow_step_execution.zig");
const import_component = @import("import_component.zig");
const import_disk_image = @import("import_disk_image.zig");
const import_vm_image = @import("import_vm_image.zig");
const list_component_build_versions = @import("list_component_build_versions.zig");
const list_components = @import("list_components.zig");
const list_container_recipes = @import("list_container_recipes.zig");
const list_distribution_configurations = @import("list_distribution_configurations.zig");
const list_image_build_versions = @import("list_image_build_versions.zig");
const list_image_packages = @import("list_image_packages.zig");
const list_image_pipeline_images = @import("list_image_pipeline_images.zig");
const list_image_pipelines = @import("list_image_pipelines.zig");
const list_image_recipes = @import("list_image_recipes.zig");
const list_image_scan_finding_aggregations = @import("list_image_scan_finding_aggregations.zig");
const list_image_scan_findings = @import("list_image_scan_findings.zig");
const list_images = @import("list_images.zig");
const list_infrastructure_configurations = @import("list_infrastructure_configurations.zig");
const list_lifecycle_execution_resources = @import("list_lifecycle_execution_resources.zig");
const list_lifecycle_executions = @import("list_lifecycle_executions.zig");
const list_lifecycle_policies = @import("list_lifecycle_policies.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_waiting_workflow_steps = @import("list_waiting_workflow_steps.zig");
const list_workflow_build_versions = @import("list_workflow_build_versions.zig");
const list_workflow_executions = @import("list_workflow_executions.zig");
const list_workflow_step_executions = @import("list_workflow_step_executions.zig");
const list_workflows = @import("list_workflows.zig");
const put_component_policy = @import("put_component_policy.zig");
const put_container_recipe_policy = @import("put_container_recipe_policy.zig");
const put_image_policy = @import("put_image_policy.zig");
const put_image_recipe_policy = @import("put_image_recipe_policy.zig");
const retry_image = @import("retry_image.zig");
const send_workflow_step_action = @import("send_workflow_step_action.zig");
const start_image_pipeline_execution = @import("start_image_pipeline_execution.zig");
const start_resource_state_update = @import("start_resource_state_update.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_distribution_configuration = @import("update_distribution_configuration.zig");
const update_image_pipeline = @import("update_image_pipeline.zig");
const update_infrastructure_configuration = @import("update_infrastructure_configuration.zig");
const update_lifecycle_policy = @import("update_lifecycle_policy.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "imagebuilder";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// CancelImageCreation cancels the creation of Image. This operation can only
    /// be used on
    /// images in a non-terminal state.
    pub fn cancelImageCreation(self: *Self, allocator: std.mem.Allocator, input: cancel_image_creation.CancelImageCreationInput, options: cancel_image_creation.Options) !cancel_image_creation.CancelImageCreationOutput {
        return cancel_image_creation.execute(self, allocator, input, options);
    }

    /// Cancel a specific image lifecycle policy runtime instance.
    pub fn cancelLifecycleExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_lifecycle_execution.CancelLifecycleExecutionInput, options: cancel_lifecycle_execution.Options) !cancel_lifecycle_execution.CancelLifecycleExecutionOutput {
        return cancel_lifecycle_execution.execute(self, allocator, input, options);
    }

    /// Creates a new component that can be used to build, validate, test, and
    /// assess your
    /// image. The component is based on a YAML document that you specify using
    /// exactly one of
    /// the following methods:
    ///
    /// * Inline, using the `data` property in the request body.
    ///
    /// * A URL that points to a YAML document file stored in Amazon S3, using the
    /// `uri` property in the request body.
    pub fn createComponent(self: *Self, allocator: std.mem.Allocator, input: create_component.CreateComponentInput, options: create_component.Options) !create_component.CreateComponentOutput {
        return create_component.execute(self, allocator, input, options);
    }

    /// Creates a new container recipe. Container recipes define how images are
    /// configured,
    /// tested, and assessed.
    pub fn createContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: create_container_recipe.CreateContainerRecipeInput, options: create_container_recipe.Options) !create_container_recipe.CreateContainerRecipeOutput {
        return create_container_recipe.execute(self, allocator, input, options);
    }

    /// Creates a new distribution configuration. Distribution configurations define
    /// and
    /// configure the outputs of your pipeline.
    pub fn createDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_distribution_configuration.CreateDistributionConfigurationInput, options: create_distribution_configuration.Options) !create_distribution_configuration.CreateDistributionConfigurationOutput {
        return create_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new image. This request will create a new image along with all of
    /// the
    /// configured output resources defined in the distribution configuration. You
    /// must specify
    /// exactly one recipe for your image, using either a ContainerRecipeArn or an
    /// ImageRecipeArn.
    pub fn createImage(self: *Self, allocator: std.mem.Allocator, input: create_image.CreateImageInput, options: create_image.Options) !create_image.CreateImageOutput {
        return create_image.execute(self, allocator, input, options);
    }

    /// Creates a new image pipeline. Image pipelines enable you to automate the
    /// creation and
    /// distribution of images.
    pub fn createImagePipeline(self: *Self, allocator: std.mem.Allocator, input: create_image_pipeline.CreateImagePipelineInput, options: create_image_pipeline.Options) !create_image_pipeline.CreateImagePipelineOutput {
        return create_image_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a new image recipe. Image recipes define how images are configured,
    /// tested,
    /// and assessed.
    pub fn createImageRecipe(self: *Self, allocator: std.mem.Allocator, input: create_image_recipe.CreateImageRecipeInput, options: create_image_recipe.Options) !create_image_recipe.CreateImageRecipeOutput {
        return create_image_recipe.execute(self, allocator, input, options);
    }

    /// Creates a new infrastructure configuration. An infrastructure configuration
    /// defines
    /// the environment in which your image will be built and tested.
    pub fn createInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_infrastructure_configuration.CreateInfrastructureConfigurationInput, options: create_infrastructure_configuration.Options) !create_infrastructure_configuration.CreateInfrastructureConfigurationOutput {
        return create_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Create a lifecycle policy resource.
    pub fn createLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: create_lifecycle_policy.CreateLifecyclePolicyInput, options: create_lifecycle_policy.Options) !create_lifecycle_policy.CreateLifecyclePolicyOutput {
        return create_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Create a new workflow or a new version of an existing workflow.
    pub fn createWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_workflow.CreateWorkflowInput, options: create_workflow.Options) !create_workflow.CreateWorkflowOutput {
        return create_workflow.execute(self, allocator, input, options);
    }

    /// Deletes a component build version.
    pub fn deleteComponent(self: *Self, allocator: std.mem.Allocator, input: delete_component.DeleteComponentInput, options: delete_component.Options) !delete_component.DeleteComponentOutput {
        return delete_component.execute(self, allocator, input, options);
    }

    /// Deletes a container recipe.
    pub fn deleteContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: delete_container_recipe.DeleteContainerRecipeInput, options: delete_container_recipe.Options) !delete_container_recipe.DeleteContainerRecipeOutput {
        return delete_container_recipe.execute(self, allocator, input, options);
    }

    /// Deletes a distribution configuration.
    pub fn deleteDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_distribution_configuration.DeleteDistributionConfigurationInput, options: delete_distribution_configuration.Options) !delete_distribution_configuration.DeleteDistributionConfigurationOutput {
        return delete_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Deletes an Image Builder image resource. This does not delete any EC2 AMIs
    /// or ECR container
    /// images that are created during the image build process. You must clean those
    /// up
    /// separately, using the appropriate Amazon EC2 or Amazon ECR console actions,
    /// or API or CLI
    /// commands.
    ///
    /// * To deregister an EC2 Linux AMI, see [Deregister your
    /// Linux
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/deregister-ami.html) in the *
    /// Amazon EC2 User Guide*
    /// .
    ///
    /// * To deregister an EC2 Windows AMI, see [Deregister your
    /// Windows
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/deregister-ami.html) in the *
    /// Amazon EC2 Windows Guide*
    /// .
    ///
    /// * To delete a container image from Amazon ECR, see [Deleting
    /// an
    /// image](https://docs.aws.amazon.com/AmazonECR/latest/userguide/delete_image.html) in the *Amazon ECR User Guide*.
    pub fn deleteImage(self: *Self, allocator: std.mem.Allocator, input: delete_image.DeleteImageInput, options: delete_image.Options) !delete_image.DeleteImageOutput {
        return delete_image.execute(self, allocator, input, options);
    }

    /// Deletes an image pipeline.
    pub fn deleteImagePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_image_pipeline.DeleteImagePipelineInput, options: delete_image_pipeline.Options) !delete_image_pipeline.DeleteImagePipelineOutput {
        return delete_image_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes an image recipe.
    pub fn deleteImageRecipe(self: *Self, allocator: std.mem.Allocator, input: delete_image_recipe.DeleteImageRecipeInput, options: delete_image_recipe.Options) !delete_image_recipe.DeleteImageRecipeOutput {
        return delete_image_recipe.execute(self, allocator, input, options);
    }

    /// Deletes an infrastructure configuration.
    pub fn deleteInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_infrastructure_configuration.DeleteInfrastructureConfigurationInput, options: delete_infrastructure_configuration.Options) !delete_infrastructure_configuration.DeleteInfrastructureConfigurationOutput {
        return delete_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Delete the specified lifecycle policy resource.
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: delete_lifecycle_policy.Options) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes a specific workflow resource.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: delete_workflow.Options) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// DistributeImage distributes existing AMIs to additional regions and accounts
    /// without rebuilding the image.
    pub fn distributeImage(self: *Self, allocator: std.mem.Allocator, input: distribute_image.DistributeImageInput, options: distribute_image.Options) !distribute_image.DistributeImageOutput {
        return distribute_image.execute(self, allocator, input, options);
    }

    /// Gets a component object.
    pub fn getComponent(self: *Self, allocator: std.mem.Allocator, input: get_component.GetComponentInput, options: get_component.Options) !get_component.GetComponentOutput {
        return get_component.execute(self, allocator, input, options);
    }

    /// Gets a component policy.
    pub fn getComponentPolicy(self: *Self, allocator: std.mem.Allocator, input: get_component_policy.GetComponentPolicyInput, options: get_component_policy.Options) !get_component_policy.GetComponentPolicyOutput {
        return get_component_policy.execute(self, allocator, input, options);
    }

    /// Retrieves a container recipe.
    pub fn getContainerRecipe(self: *Self, allocator: std.mem.Allocator, input: get_container_recipe.GetContainerRecipeInput, options: get_container_recipe.Options) !get_container_recipe.GetContainerRecipeOutput {
        return get_container_recipe.execute(self, allocator, input, options);
    }

    /// Retrieves the policy for a container recipe.
    pub fn getContainerRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: get_container_recipe_policy.GetContainerRecipePolicyInput, options: get_container_recipe_policy.Options) !get_container_recipe_policy.GetContainerRecipePolicyOutput {
        return get_container_recipe_policy.execute(self, allocator, input, options);
    }

    /// Gets a distribution configuration.
    pub fn getDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_distribution_configuration.GetDistributionConfigurationInput, options: get_distribution_configuration.Options) !get_distribution_configuration.GetDistributionConfigurationOutput {
        return get_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Gets an image.
    pub fn getImage(self: *Self, allocator: std.mem.Allocator, input: get_image.GetImageInput, options: get_image.Options) !get_image.GetImageOutput {
        return get_image.execute(self, allocator, input, options);
    }

    /// Gets an image pipeline.
    pub fn getImagePipeline(self: *Self, allocator: std.mem.Allocator, input: get_image_pipeline.GetImagePipelineInput, options: get_image_pipeline.Options) !get_image_pipeline.GetImagePipelineOutput {
        return get_image_pipeline.execute(self, allocator, input, options);
    }

    /// Gets an image policy.
    pub fn getImagePolicy(self: *Self, allocator: std.mem.Allocator, input: get_image_policy.GetImagePolicyInput, options: get_image_policy.Options) !get_image_policy.GetImagePolicyOutput {
        return get_image_policy.execute(self, allocator, input, options);
    }

    /// Gets an image recipe.
    pub fn getImageRecipe(self: *Self, allocator: std.mem.Allocator, input: get_image_recipe.GetImageRecipeInput, options: get_image_recipe.Options) !get_image_recipe.GetImageRecipeOutput {
        return get_image_recipe.execute(self, allocator, input, options);
    }

    /// Gets an image recipe policy.
    pub fn getImageRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: get_image_recipe_policy.GetImageRecipePolicyInput, options: get_image_recipe_policy.Options) !get_image_recipe_policy.GetImageRecipePolicyOutput {
        return get_image_recipe_policy.execute(self, allocator, input, options);
    }

    /// Gets an infrastructure configuration.
    pub fn getInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_infrastructure_configuration.GetInfrastructureConfigurationInput, options: get_infrastructure_configuration.Options) !get_infrastructure_configuration.GetInfrastructureConfigurationOutput {
        return get_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Get the runtime information that was logged for a specific runtime instance
    /// of the lifecycle policy.
    pub fn getLifecycleExecution(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_execution.GetLifecycleExecutionInput, options: get_lifecycle_execution.Options) !get_lifecycle_execution.GetLifecycleExecutionOutput {
        return get_lifecycle_execution.execute(self, allocator, input, options);
    }

    /// Get details for the specified image lifecycle policy.
    pub fn getLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy.GetLifecyclePolicyInput, options: get_lifecycle_policy.Options) !get_lifecycle_policy.GetLifecyclePolicyOutput {
        return get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Verify the subscription and perform resource dependency checks on the
    /// requested
    /// Amazon Web Services Marketplace resource. For Amazon Web Services
    /// Marketplace components, the response contains fields to download the
    /// components and their artifacts.
    pub fn getMarketplaceResource(self: *Self, allocator: std.mem.Allocator, input: get_marketplace_resource.GetMarketplaceResourceInput, options: get_marketplace_resource.Options) !get_marketplace_resource.GetMarketplaceResourceOutput {
        return get_marketplace_resource.execute(self, allocator, input, options);
    }

    /// Get a workflow resource object.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: get_workflow.Options) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Get the runtime information that was logged for a specific runtime instance
    /// of the workflow.
    pub fn getWorkflowExecution(self: *Self, allocator: std.mem.Allocator, input: get_workflow_execution.GetWorkflowExecutionInput, options: get_workflow_execution.Options) !get_workflow_execution.GetWorkflowExecutionOutput {
        return get_workflow_execution.execute(self, allocator, input, options);
    }

    /// Get the runtime information that was logged for a specific runtime instance
    /// of
    /// the workflow step.
    pub fn getWorkflowStepExecution(self: *Self, allocator: std.mem.Allocator, input: get_workflow_step_execution.GetWorkflowStepExecutionInput, options: get_workflow_step_execution.Options) !get_workflow_step_execution.GetWorkflowStepExecutionOutput {
        return get_workflow_step_execution.execute(self, allocator, input, options);
    }

    /// Imports a component and transforms its data into a component document.
    pub fn importComponent(self: *Self, allocator: std.mem.Allocator, input: import_component.ImportComponentInput, options: import_component.Options) !import_component.ImportComponentOutput {
        return import_component.execute(self, allocator, input, options);
    }

    /// Import a Windows operating system image from a verified Microsoft ISO disk
    /// file. The following disk images are supported:
    ///
    /// * Windows 11 Enterprise
    pub fn importDiskImage(self: *Self, allocator: std.mem.Allocator, input: import_disk_image.ImportDiskImageInput, options: import_disk_image.Options) !import_disk_image.ImportDiskImageOutput {
        return import_disk_image.execute(self, allocator, input, options);
    }

    /// When you export your virtual machine (VM) from its virtualization
    /// environment, that
    /// process creates a set of one or more disk container files that act as
    /// snapshots of your
    /// VM’s environment, settings, and data. The Amazon EC2 API
    /// [ImportImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportImage.html)
    /// action uses those files to import your VM and create an AMI. To import using
    /// the CLI
    /// command, see
    /// [import-image](https://docs.aws.amazon.com/cli/latest/reference/ec2/import-image.html)
    ///
    /// You can reference the task ID from the VM import to pull in the AMI that the
    /// import
    /// created as the base image for your Image Builder recipe.
    pub fn importVmImage(self: *Self, allocator: std.mem.Allocator, input: import_vm_image.ImportVmImageInput, options: import_vm_image.Options) !import_vm_image.ImportVmImageOutput {
        return import_vm_image.execute(self, allocator, input, options);
    }

    /// Returns the list of component build versions for the specified component
    /// version Amazon Resource Name (ARN).
    pub fn listComponentBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_component_build_versions.ListComponentBuildVersionsInput, options: list_component_build_versions.Options) !list_component_build_versions.ListComponentBuildVersionsOutput {
        return list_component_build_versions.execute(self, allocator, input, options);
    }

    /// Returns the list of components that can be filtered by name, or by using the
    /// listed
    /// `filters` to streamline results. Newly created components can take up to
    /// two minutes to appear in the ListComponents API Results.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Filtering:** With semantic versioning, you have the flexibility to use
    /// wildcards (x)
    /// to specify the most recent versions or nodes when selecting the base image
    /// or components for your
    /// recipe. When you use a wildcard in any node, all nodes to the right of the
    /// first wildcard must also be
    /// wildcards.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: list_components.Options) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Returns a list of container recipes.
    pub fn listContainerRecipes(self: *Self, allocator: std.mem.Allocator, input: list_container_recipes.ListContainerRecipesInput, options: list_container_recipes.Options) !list_container_recipes.ListContainerRecipesOutput {
        return list_container_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of distribution configurations.
    pub fn listDistributionConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_distribution_configurations.ListDistributionConfigurationsInput, options: list_distribution_configurations.Options) !list_distribution_configurations.ListDistributionConfigurationsOutput {
        return list_distribution_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of image build versions.
    pub fn listImageBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_image_build_versions.ListImageBuildVersionsInput, options: list_image_build_versions.Options) !list_image_build_versions.ListImageBuildVersionsOutput {
        return list_image_build_versions.execute(self, allocator, input, options);
    }

    /// List the Packages that are associated with an Image Build Version, as
    /// determined by
    /// Amazon Web Services Systems Manager Inventory at build time.
    pub fn listImagePackages(self: *Self, allocator: std.mem.Allocator, input: list_image_packages.ListImagePackagesInput, options: list_image_packages.Options) !list_image_packages.ListImagePackagesOutput {
        return list_image_packages.execute(self, allocator, input, options);
    }

    /// Returns a list of images created by the specified pipeline.
    pub fn listImagePipelineImages(self: *Self, allocator: std.mem.Allocator, input: list_image_pipeline_images.ListImagePipelineImagesInput, options: list_image_pipeline_images.Options) !list_image_pipeline_images.ListImagePipelineImagesOutput {
        return list_image_pipeline_images.execute(self, allocator, input, options);
    }

    /// Returns a list of image pipelines.
    pub fn listImagePipelines(self: *Self, allocator: std.mem.Allocator, input: list_image_pipelines.ListImagePipelinesInput, options: list_image_pipelines.Options) !list_image_pipelines.ListImagePipelinesOutput {
        return list_image_pipelines.execute(self, allocator, input, options);
    }

    /// Returns a list of image recipes.
    pub fn listImageRecipes(self: *Self, allocator: std.mem.Allocator, input: list_image_recipes.ListImageRecipesInput, options: list_image_recipes.Options) !list_image_recipes.ListImageRecipesOutput {
        return list_image_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of image scan aggregations for your account. You can filter
    /// by the type
    /// of key that Image Builder uses to group results. For example, if you want to
    /// get a list of
    /// findings by severity level for one of your pipelines, you might specify your
    /// pipeline
    /// with the `imagePipelineArn` filter. If you don't specify a filter, Image
    /// Builder
    /// returns an aggregation for your account.
    ///
    /// To streamline results, you can use the following filters in your request:
    ///
    /// * `accountId`
    ///
    /// * `imageBuildVersionArn`
    ///
    /// * `imagePipelineArn`
    ///
    /// * `vulnerabilityId`
    pub fn listImageScanFindingAggregations(self: *Self, allocator: std.mem.Allocator, input: list_image_scan_finding_aggregations.ListImageScanFindingAggregationsInput, options: list_image_scan_finding_aggregations.Options) !list_image_scan_finding_aggregations.ListImageScanFindingAggregationsOutput {
        return list_image_scan_finding_aggregations.execute(self, allocator, input, options);
    }

    /// Returns a list of image scan findings for your account.
    pub fn listImageScanFindings(self: *Self, allocator: std.mem.Allocator, input: list_image_scan_findings.ListImageScanFindingsInput, options: list_image_scan_findings.Options) !list_image_scan_findings.ListImageScanFindingsOutput {
        return list_image_scan_findings.execute(self, allocator, input, options);
    }

    /// Returns the list of images that you have access to. Newly created images can
    /// take up
    /// to two minutes to appear in the ListImages API Results.
    pub fn listImages(self: *Self, allocator: std.mem.Allocator, input: list_images.ListImagesInput, options: list_images.Options) !list_images.ListImagesOutput {
        return list_images.execute(self, allocator, input, options);
    }

    /// Returns a list of infrastructure configurations.
    pub fn listInfrastructureConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_infrastructure_configurations.ListInfrastructureConfigurationsInput, options: list_infrastructure_configurations.Options) !list_infrastructure_configurations.ListInfrastructureConfigurationsOutput {
        return list_infrastructure_configurations.execute(self, allocator, input, options);
    }

    /// List resources that the runtime instance of the image lifecycle identified
    /// for lifecycle actions.
    pub fn listLifecycleExecutionResources(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_execution_resources.ListLifecycleExecutionResourcesInput, options: list_lifecycle_execution_resources.Options) !list_lifecycle_execution_resources.ListLifecycleExecutionResourcesOutput {
        return list_lifecycle_execution_resources.execute(self, allocator, input, options);
    }

    /// Get the lifecycle runtime history for the specified resource.
    pub fn listLifecycleExecutions(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_executions.ListLifecycleExecutionsInput, options: list_lifecycle_executions.Options) !list_lifecycle_executions.ListLifecycleExecutionsOutput {
        return list_lifecycle_executions.execute(self, allocator, input, options);
    }

    /// Get a list of lifecycle policies in your Amazon Web Services account.
    pub fn listLifecyclePolicies(self: *Self, allocator: std.mem.Allocator, input: list_lifecycle_policies.ListLifecyclePoliciesInput, options: list_lifecycle_policies.Options) !list_lifecycle_policies.ListLifecyclePoliciesOutput {
        return list_lifecycle_policies.execute(self, allocator, input, options);
    }

    /// Returns the list of tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Get a list of workflow steps that are waiting for action for workflows
    /// in your Amazon Web Services account.
    pub fn listWaitingWorkflowSteps(self: *Self, allocator: std.mem.Allocator, input: list_waiting_workflow_steps.ListWaitingWorkflowStepsInput, options: list_waiting_workflow_steps.Options) !list_waiting_workflow_steps.ListWaitingWorkflowStepsOutput {
        return list_waiting_workflow_steps.execute(self, allocator, input, options);
    }

    /// Returns a list of build versions for a specific workflow resource.
    pub fn listWorkflowBuildVersions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_build_versions.ListWorkflowBuildVersionsInput, options: list_workflow_build_versions.Options) !list_workflow_build_versions.ListWorkflowBuildVersionsOutput {
        return list_workflow_build_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of workflow runtime instance metadata objects for a specific
    /// image build
    /// version.
    pub fn listWorkflowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_executions.ListWorkflowExecutionsInput, options: list_workflow_executions.Options) !list_workflow_executions.ListWorkflowExecutionsOutput {
        return list_workflow_executions.execute(self, allocator, input, options);
    }

    /// Returns runtime data for each step in a runtime instance of the workflow
    /// that you specify in the request.
    pub fn listWorkflowStepExecutions(self: *Self, allocator: std.mem.Allocator, input: list_workflow_step_executions.ListWorkflowStepExecutionsInput, options: list_workflow_step_executions.Options) !list_workflow_step_executions.ListWorkflowStepExecutionsOutput {
        return list_workflow_step_executions.execute(self, allocator, input, options);
    }

    /// Lists workflow build versions based on filtering parameters.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: list_workflows.Options) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Applies a policy to a component. We recommend that you call the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html) to share resources. If you call the Image Builder API
    /// `PutComponentPolicy`, you must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html) in order for the resource to be
    /// visible to all principals with whom the resource is shared.
    pub fn putComponentPolicy(self: *Self, allocator: std.mem.Allocator, input: put_component_policy.PutComponentPolicyInput, options: put_component_policy.Options) !put_component_policy.PutComponentPolicyOutput {
        return put_component_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to a container image. We recommend that you call the RAM
    /// API
    /// CreateResourceShare
    /// (https://docs.aws.amazon.com//ram/latest/APIReference/API_CreateResourceShare.html) to share
    /// resources. If you call the Image Builder API `PutContainerImagePolicy`, you
    /// must also
    /// call the RAM API PromoteResourceShareCreatedFromPolicy
    /// (https://docs.aws.amazon.com//ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html)
    /// in order for the resource to be visible to all principals with whom the
    /// resource is
    /// shared.
    pub fn putContainerRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: put_container_recipe_policy.PutContainerRecipePolicyInput, options: put_container_recipe_policy.Options) !put_container_recipe_policy.PutContainerRecipePolicyOutput {
        return put_container_recipe_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to an image. We recommend that you call the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html) to share resources. If you call the Image Builder API
    /// `PutImagePolicy`, you must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html) in order for the resource to be
    /// visible to all principals with whom the resource is shared.
    pub fn putImagePolicy(self: *Self, allocator: std.mem.Allocator, input: put_image_policy.PutImagePolicyInput, options: put_image_policy.Options) !put_image_policy.PutImagePolicyOutput {
        return put_image_policy.execute(self, allocator, input, options);
    }

    /// Applies a policy to an image recipe. We recommend that you call the RAM API
    /// [CreateResourceShare](https://docs.aws.amazon.com/ram/latest/APIReference/API_CreateResourceShare.html) to share resources. If you call the Image Builder API
    /// `PutImageRecipePolicy`, you must also call the RAM API
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html) in order for the resource to be
    /// visible to all principals with whom the resource is shared.
    pub fn putImageRecipePolicy(self: *Self, allocator: std.mem.Allocator, input: put_image_recipe_policy.PutImageRecipePolicyInput, options: put_image_recipe_policy.Options) !put_image_recipe_policy.PutImageRecipePolicyOutput {
        return put_image_recipe_policy.execute(self, allocator, input, options);
    }

    /// RetryImage retries an image distribution without rebuilding the image.
    pub fn retryImage(self: *Self, allocator: std.mem.Allocator, input: retry_image.RetryImageInput, options: retry_image.Options) !retry_image.RetryImageOutput {
        return retry_image.execute(self, allocator, input, options);
    }

    /// Pauses or resumes image creation when the associated workflow runs a
    /// `WaitForAction` step.
    pub fn sendWorkflowStepAction(self: *Self, allocator: std.mem.Allocator, input: send_workflow_step_action.SendWorkflowStepActionInput, options: send_workflow_step_action.Options) !send_workflow_step_action.SendWorkflowStepActionOutput {
        return send_workflow_step_action.execute(self, allocator, input, options);
    }

    /// Manually triggers a pipeline to create an image.
    pub fn startImagePipelineExecution(self: *Self, allocator: std.mem.Allocator, input: start_image_pipeline_execution.StartImagePipelineExecutionInput, options: start_image_pipeline_execution.Options) !start_image_pipeline_execution.StartImagePipelineExecutionOutput {
        return start_image_pipeline_execution.execute(self, allocator, input, options);
    }

    /// Begin asynchronous resource state update for lifecycle changes to the
    /// specified image resources.
    pub fn startResourceStateUpdate(self: *Self, allocator: std.mem.Allocator, input: start_resource_state_update.StartResourceStateUpdateInput, options: start_resource_state_update.Options) !start_resource_state_update.StartResourceStateUpdateOutput {
        return start_resource_state_update.execute(self, allocator, input, options);
    }

    /// Adds a tag to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a new distribution configuration. Distribution configurations define
    /// and
    /// configure the outputs of your pipeline.
    pub fn updateDistributionConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_distribution_configuration.UpdateDistributionConfigurationInput, options: update_distribution_configuration.Options) !update_distribution_configuration.UpdateDistributionConfigurationOutput {
        return update_distribution_configuration.execute(self, allocator, input, options);
    }

    /// Updates an image pipeline. Image pipelines enable you to automate the
    /// creation and
    /// distribution of images. You must specify exactly one recipe for your image,
    /// using either
    /// a `containerRecipeArn` or an `imageRecipeArn`.
    ///
    /// UpdateImagePipeline does not support selective updates for the pipeline. You
    /// must
    /// specify all of the required properties in the update request, not just the
    /// properties that have changed.
    pub fn updateImagePipeline(self: *Self, allocator: std.mem.Allocator, input: update_image_pipeline.UpdateImagePipelineInput, options: update_image_pipeline.Options) !update_image_pipeline.UpdateImagePipelineOutput {
        return update_image_pipeline.execute(self, allocator, input, options);
    }

    /// Updates a new infrastructure configuration. An infrastructure configuration
    /// defines
    /// the environment in which your image will be built and tested.
    pub fn updateInfrastructureConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_infrastructure_configuration.UpdateInfrastructureConfigurationInput, options: update_infrastructure_configuration.Options) !update_infrastructure_configuration.UpdateInfrastructureConfigurationOutput {
        return update_infrastructure_configuration.execute(self, allocator, input, options);
    }

    /// Update the specified lifecycle policy.
    pub fn updateLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: update_lifecycle_policy.UpdateLifecyclePolicyInput, options: update_lifecycle_policy.Options) !update_lifecycle_policy.UpdateLifecyclePolicyOutput {
        return update_lifecycle_policy.execute(self, allocator, input, options);
    }

    pub fn listComponentBuildVersionsPaginator(self: *Self, params: list_component_build_versions.ListComponentBuildVersionsInput) paginator.ListComponentBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContainerRecipesPaginator(self: *Self, params: list_container_recipes.ListContainerRecipesInput) paginator.ListContainerRecipesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDistributionConfigurationsPaginator(self: *Self, params: list_distribution_configurations.ListDistributionConfigurationsInput) paginator.ListDistributionConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageBuildVersionsPaginator(self: *Self, params: list_image_build_versions.ListImageBuildVersionsInput) paginator.ListImageBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagePackagesPaginator(self: *Self, params: list_image_packages.ListImagePackagesInput) paginator.ListImagePackagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagePipelineImagesPaginator(self: *Self, params: list_image_pipeline_images.ListImagePipelineImagesInput) paginator.ListImagePipelineImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagePipelinesPaginator(self: *Self, params: list_image_pipelines.ListImagePipelinesInput) paginator.ListImagePipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageRecipesPaginator(self: *Self, params: list_image_recipes.ListImageRecipesInput) paginator.ListImageRecipesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageScanFindingAggregationsPaginator(self: *Self, params: list_image_scan_finding_aggregations.ListImageScanFindingAggregationsInput) paginator.ListImageScanFindingAggregationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImageScanFindingsPaginator(self: *Self, params: list_image_scan_findings.ListImageScanFindingsInput) paginator.ListImageScanFindingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagesPaginator(self: *Self, params: list_images.ListImagesInput) paginator.ListImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInfrastructureConfigurationsPaginator(self: *Self, params: list_infrastructure_configurations.ListInfrastructureConfigurationsInput) paginator.ListInfrastructureConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLifecycleExecutionResourcesPaginator(self: *Self, params: list_lifecycle_execution_resources.ListLifecycleExecutionResourcesInput) paginator.ListLifecycleExecutionResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLifecycleExecutionsPaginator(self: *Self, params: list_lifecycle_executions.ListLifecycleExecutionsInput) paginator.ListLifecycleExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLifecyclePoliciesPaginator(self: *Self, params: list_lifecycle_policies.ListLifecyclePoliciesInput) paginator.ListLifecyclePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWaitingWorkflowStepsPaginator(self: *Self, params: list_waiting_workflow_steps.ListWaitingWorkflowStepsInput) paginator.ListWaitingWorkflowStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowBuildVersionsPaginator(self: *Self, params: list_workflow_build_versions.ListWorkflowBuildVersionsInput) paginator.ListWorkflowBuildVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowExecutionsPaginator(self: *Self, params: list_workflow_executions.ListWorkflowExecutionsInput) paginator.ListWorkflowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowStepExecutionsPaginator(self: *Self, params: list_workflow_step_executions.ListWorkflowStepExecutionsInput) paginator.ListWorkflowStepExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkflowsPaginator(self: *Self, params: list_workflows.ListWorkflowsInput) paginator.ListWorkflowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};

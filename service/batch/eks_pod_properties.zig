const EksContainer = @import("eks_container.zig").EksContainer;
const ImagePullSecret = @import("image_pull_secret.zig").ImagePullSecret;
const EksMetadata = @import("eks_metadata.zig").EksMetadata;
const EksVolume = @import("eks_volume.zig").EksVolume;

/// The properties for the pod.
pub const EksPodProperties = struct {
    /// The properties of the container that's used on the Amazon EKS pod.
    ///
    /// This object is limited to 10 elements.
    containers: ?[]const EksContainer = null,

    /// The DNS policy for the pod. The default value is `ClusterFirst`. If the
    /// `hostNetwork` parameter is not specified, the default is
    /// `ClusterFirstWithHostNet`. `ClusterFirst` indicates that any DNS query
    /// that does not match the configured cluster domain suffix is forwarded to the
    /// upstream nameserver
    /// inherited from the node. For more information, see [Pod's DNS
    /// policy](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/#pod-s-dns-policy) in the *Kubernetes documentation*.
    ///
    /// Valid values: `Default` | `ClusterFirst` |
    /// `ClusterFirstWithHostNet`
    dns_policy: ?[]const u8 = null,

    /// Indicates if the pod uses the hosts' network IP address. The default value
    /// is
    /// `true`. Setting this to `false` enables the Kubernetes pod networking model.
    /// Most Batch workloads are egress-only and don't require the overhead of IP
    /// allocation for each
    /// pod for incoming connections. For more information, see [Host
    /// namespaces](https://kubernetes.io/docs/concepts/security/pod-security-policy/#host-namespaces) and [Pod networking](https://kubernetes.io/docs/concepts/workloads/pods/#pod-networking)
    /// in the *Kubernetes documentation*.
    host_network: ?bool = null,

    /// References a Kubernetes secret resource. It holds a list of secrets. These
    /// secrets help to gain
    /// access to pull an images from a private registry.
    ///
    /// `ImagePullSecret$name` is required when this object is used.
    image_pull_secrets: ?[]const ImagePullSecret = null,

    /// These containers run before application containers, always runs to
    /// completion, and must
    /// complete successfully before the next container starts. These containers are
    /// registered with the
    /// Amazon EKS Connector agent and persists the registration information in the
    /// Kubernetes backend data store.
    /// For more information, see [Init
    /// Containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) in the *Kubernetes documentation*.
    ///
    /// This object is limited to 10 elements.
    init_containers: ?[]const EksContainer = null,

    /// Metadata about the Kubernetes pod. For more information, see [Understanding
    /// Kubernetes
    /// Objects](https://kubernetes.io/docs/concepts/overview/working-with-objects/kubernetes-objects/) in the *Kubernetes
    /// documentation*.
    metadata: ?EksMetadata = null,

    /// The name of the service account that's used to run the pod. For more
    /// information, see
    /// [Kubernetes service
    /// accounts](https://docs.aws.amazon.com/eks/latest/userguide/service-accounts.html) and [Configure a Kubernetes service account
    /// to assume an IAM
    /// role](https://docs.aws.amazon.com/eks/latest/userguide/associate-service-account-role.html) in the *Amazon EKS User Guide* and [Configure service accounts for pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) in the *Kubernetes
    /// documentation*.
    service_account_name: ?[]const u8 = null,

    /// Indicates if the processes in a container are shared, or visible, to other
    /// containers in the
    /// same pod. For more information, see [Share
    /// Process Namespace between Containers in a
    /// Pod](https://kubernetes.io/docs/tasks/configure-pod-container/share-process-namespace/).
    share_process_namespace: ?bool = null,

    /// Specifies the volumes for a job definition that uses Amazon EKS resources.
    volumes: ?[]const EksVolume = null,

    pub const json_field_names = .{
        .containers = "containers",
        .dns_policy = "dnsPolicy",
        .host_network = "hostNetwork",
        .image_pull_secrets = "imagePullSecrets",
        .init_containers = "initContainers",
        .metadata = "metadata",
        .service_account_name = "serviceAccountName",
        .share_process_namespace = "shareProcessNamespace",
        .volumes = "volumes",
    };
};

using System.Net;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Azure.Functions.Worker.Http;
using Microsoft.Extensions.Logging;

namespace azure_func_devops
{
    public class Greetings
    {
        private readonly ILogger _logger;

        public Greetings(ILoggerFactory loggerFactory)
        {
            _logger = loggerFactory.CreateLogger<Greetings>();
        }

        [Function("greetings")]
        public HttpResponseData Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post")] HttpRequestData req)
        {
            _logger.LogInformation("Function triggered!");
            if (req.Method == "GET")
            {
                string? callerName = req.Query["name"];
                var response = req.CreateResponse(HttpStatusCode.OK);
                response.Headers.Add("Content-Type", "text/plain; charset=utf-8");
                response.WriteString($"Hello {callerName}. You've successfully triggered the function!");
                return response;
            }
            var responseData = req.CreateResponse(HttpStatusCode.Accepted);
            return responseData;
        }
    }
}

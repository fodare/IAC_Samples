using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace GreeetingsFunction
{
    public class Greetings
    {
        private readonly ILogger<Greetings> _logger;

        public Greetings(ILogger<Greetings> logger)
        {
            _logger = logger;
        }

        [Function("Greetings")]
        public async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "greetings")] HttpRequest req)
        {
            _logger.LogInformation("Function app triggred!");
            if (req.Method == "GET")
            {
                string? queryName = req.Query["name"];
                string serverMessage = @$"Hello {queryName}. You successfully triggred the test function app.";
                return new OkObjectResult(serverMessage);
            }
            string dynamicRequestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic jsonRequestData = JsonConvert.DeserializeObject(dynamicRequestBody);
            return new OkObjectResult($"Received {jsonRequestData}");
        }
    }
}

using System;
using System.IO;
using System.Threading.Tasks;

namespace Services_Pwsh
{
    class Program
    {
        static async Task Main(string[] args)
        {
            while (true)
            {
                File.WriteAllText("./output.txt", DateTime.Now.ToShortTimeString());
                await Task.Delay((int)TimeSpan.FromSeconds(30).TotalMilliseconds);
            }
        }
    }
}

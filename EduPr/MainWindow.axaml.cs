using Avalonia.Controls;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;

namespace EduPr
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }
        private async void Button_Click(object? sender, Avalonia.Interactivity.RoutedEventArgs e)
        {
            string login = LoginTb.Text;
            string password = PasswordTb.Text;
            var context = new AppDbContext();

            if (string.IsNullOrWhiteSpace(login))
            {
                System.Console.WriteLine($"Неверный логин {login}");
                return;
            }
            if (string.IsNullOrWhiteSpace(password))
            {
                return;
            }


            var user = await context.Users
                .Include(u => u.IdRoleNavigation)
                .Include(u => u.Doctor)
                .FirstOrDefaultAsync(u => u.LoginUser == login);
            if (user == null || user.PasswordUser != password)
            {
                return;
            }
            if (user.IdRoleNavigation == null)
                return;
            var parent = this.VisualRoot as Window;
            if (parent == null) return;
            switch (user.IdRoleNavigation.NameRole)
            {
                case "Администратор":
                    new AdminWindow().Show();
                    this.Close();
                    break;

                case "Врач":
                    var doctorWindow = new DoctorWindow(user.Doctor);
                    doctorWindow.Show();
                    break;

                case "Руководитель":
                    var headWindow = new HeadMainWindow();
                    headWindow.Show();
                    break;

                default:
                    return;
            }
            parent.Close();
        }
    }
}
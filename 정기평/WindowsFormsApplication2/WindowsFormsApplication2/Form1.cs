using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApplication2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public double Crossover_P = 0.5;
        public double Mutation_P = 0.05;

        Random rnd = new Random();
        int[] t; //시간
        int[] c; //벌금
        int[] p; //시간누적
        int[] o; //작업순서
        int[] t_o; //시간순서 재배열
        int[] c_o; //벌금 재배열
        int[] d; //due date
        int[] d_o; //due date 재배열
        int n; //작업수
        int penalty; //총페널티
        int k;  //시간누적값을 위한 정수

        public struct SOLUTION
        {
            public int[] chromo;
            public int cost;
        }
        public SOLUTION[] tt;
        public SOLUTION[] tt_;
        public SOLUTION[] Best_chromo;
        public void initial_solution()//랜덤 배열 10개 생성
        {
            tt = new SOLUTION[20];
            for (int i = 0; i < 20; i++)
            {
                int[] n_o = new int[n];
                for (int j = 0; j < n; j++)
                {
                    n_o[j] = rnd.Next(1, n + 1);
                    int y = 0;
                    while (y < j)
                    {
                        if (n_o[j] == n_o[y])
                        {
                            n_o[j] = rnd.Next(1, n + 1);
                            y = 0;
                        }
                        else
                        {
                            y = y + 1;
                        }
                    }
                }
                tt[i].chromo = n_o;
            }

        }
        public void Next_gen()
        {
            int x = 0;//오름차순정렬
            while (x < 20)
            {
                for (int i = 0; i < tt.Length - 1; i++)
                {
                    SOLUTION EMsave = tt[i];
                    if (tt[i].cost > tt[i + 1].cost)
                    {
                        tt[i] = tt[i + 1];
                        tt[i + 1] = EMsave;
                    }
                }
                x = x + 1;
            }
            tt_[0] = tt[0];
            tt_[1] = tt[1];
        }
        public int[] Crossover(int index1, int index2)
        {
            int Cutpoint = rnd.Next(0, n);
            int[] Parent1 = tt[index1].chromo;
            int[] Parent2 = tt[index2].chromo;
            int[] Child = new int[n];
            Child = Parent1;

            if (rnd.NextDouble() < Crossover_P)
            {
                for (int i = 0; i <= Cutpoint; i++)
                {
                    Child[i] = Parent2[i];
                }
            }
            return Child;
        }
        public void Mutation(int[] mmm)
        {
            int z;
            for (int i = 0; i < n; i++)
            {
                z = 0;
                z = mmm[i];
                if (rnd.NextDouble() < Mutation_P)
                {
                    if (i != n - 1)
                    {
                        mmm[i] = mmm[n - 1];
                        mmm[n - 1] = z;
                    }
                }
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            penalty = 0;
            k = 0;
            string Job = textBox1.Text;
            n = Convert.ToInt32(Job);
            p = new int[n];
            string st = textBox2.Text;
            string[] input1 = st.Split(',');
            t = new int[input1.Length];
            string sst = textBox3.Text;
            string[] input2 = sst.Split(',');
            c = new int[input2.Length];
            string ssst = textBox5.Text;
            string[] input3 = ssst.Split(',');
            o = new int[input3.Length];
            t_o = new int[input3.Length];
            c_o = new int[input3.Length];
            string sssst = textBox4.Text;
            string[] input4 = sssst.Split(',');
            d = new int[input4.Length];
            d_o = new int[input4.Length];
            initial_solution();
            for (int i = 0; i < n; i++)
            {
                o[i] = Convert.ToInt32(input3[i]);
                c[i] = Convert.ToInt32(input2[i]);
                t[i] = Convert.ToInt32(input1[i]);
                d[i] = Convert.ToInt32(input4[i]);
            }

            for (int i = 0; i < tt.Length; i++)//랜덤 시퀀스에 대한 코스트
            {
                penalty = 0;
                k = 0;
                t_o = new int[n];
                d_o = new int[n];
                c_o = new int[n];
                for (int j = 0; j < n; j++)
                {
                    t_o[j] = t[tt[i].chromo[j] - 1];
                    c_o[j] = c[tt[i].chromo[j] - 1];
                    d_o[j] = d[tt[i].chromo[j] - 1];
                    k += t_o[j];
                    p[j] = k;
                }
                for (int j = 0; j < n; j++)
                {
                    if (p[j] > d_o[j])
                    {
                        penalty += (p[j] - d_o[j]) * c_o[j];
                    }
                }
                tt[i].cost = penalty;
            }
            // public void Next_gen()
            // {
            //     int x = 0;//오름차순정렬
            //     while (x<20)
            //     {
            //         for (int i = 0; i <tt.Length-1; i++)
            //         {
            //             SOLUTION EMsave=tt[i];
            //             if (tt[i].cost>tt[i+1].cost)
            //             {
            //                 tt[i] = tt[i+1];
            //                 tt[i+1] = EMsave;
            //             }
            //         }
            //         x = x + 1;
            //     }
            // }
            // 
            //for (int i = 0; i < n; i++)
            //{
            //    k += t_o[i];
            //    p[i] = k;
            //}
            //for (int i = 0; i <n; i++)
            //{
            //    if (p[i]>d_o[i])
            //    {
            //        penalty += (p[i] - d_o[i]) * c_o[i];
            //    }
            //    else
            //    {
            //        penalty = penalty;
            //    }
            //}
            //for (int i = 0; i < n - 1; i++)
            //{
            //    penalty += p[i] * c_o[i + 1];
            //}
            textBox6.Text = penalty.ToString();

        }
    }
}

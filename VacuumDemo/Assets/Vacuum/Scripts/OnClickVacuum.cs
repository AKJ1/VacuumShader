using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;

namespace Assets.Scripts.HUD
{
    public class MouseShader : MonoBehaviour
    {
        public Vector2 LockedPosition = Vector3.zero;
        public void Update()
        {
           if (Input.GetMouseButtonDown(0))
           {
                transform.GetComponent<Animator>().SetTrigger("Triggered");
           }

            transform.position = Camera.main.ScreenPointToRay(Input.mousePosition).GetPoint(15);
        }
    }
}
